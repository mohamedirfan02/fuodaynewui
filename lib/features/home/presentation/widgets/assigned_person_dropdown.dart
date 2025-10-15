import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/emp_department_entity.dart';
import '../provider/employee_department_provider.dart';

class AssignedPersonDropdownCheckbox extends StatefulWidget {
  final String? label;
  final Function(List<EmployeeModelEntity>)? onSelectionChanged;
  final bool floatingLabel;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;

  const AssignedPersonDropdownCheckbox({
    super.key,
    this.label,
    this.onSelectionChanged,
    this.floatingLabel = false,
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
  });

  static AssignedPersonDropdownCheckboxState? of(BuildContext context) =>
      context.findAncestorStateOfType<AssignedPersonDropdownCheckboxState>();

  @override
  State<AssignedPersonDropdownCheckbox> createState() =>
      AssignedPersonDropdownCheckboxState();
}

class AssignedPersonDropdownCheckboxState
    extends State<AssignedPersonDropdownCheckbox>
    with SingleTickerProviderStateMixin {
  final List<EmployeeModelEntity> _selectedEmployees = [];
  bool _isDropdownOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInCubic),
    );

    final hiveService = getIt<HiveStorageService>();
    final webUserIdStr = hiveService.employeeDetails?['web_user_id'];
    final int? webUserId = webUserIdStr is int
        ? webUserIdStr
        : int.tryParse(webUserIdStr?.toString() ?? '');

    if (webUserId != null) {
      Future.microtask(() {
        Provider.of<EmployeeDepartmentProvider>(
          context,
          listen: false,
        ).fetchEmployees(webUserId);
      });
    } else {
      debugPrint('⚠️ webUserId is null or invalid');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });

    if (_isDropdownOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void closeDropdown() {
    if (_isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
      _animationController.reverse();
    }
  }

  void clearSelection() {
    if (_selectedEmployees.isNotEmpty) {
      setState(() {
        _selectedEmployees.clear();
      });
      widget.onSelectionChanged?.call(List<EmployeeModelEntity>.from([]));
    }
  }

  void _onItemSelected(EmployeeModelEntity emp, bool selected) {
    setState(() {
      if (selected) {
        _selectedEmployees.add(emp);
      } else {
        _selectedEmployees.remove(emp);
      }
    });

    widget.onSelectionChanged?.call(_selectedEmployees);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDepartmentProvider>(
      builder: (context, provider, _) {
        final isLoading = provider.isLoading;
        final employees = provider.employeeDepartment?.sameDepartment ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null && !widget.floatingLabel) ...[
              Text(
                widget.label!,
                style: GoogleFonts.sora(
                  fontSize: widget.labelFontSize ?? 12.sp,
                  fontWeight: widget.labelFontWeight ?? FontWeight.w600,
                  color: widget.labelColor ?? AppColors.titleColor,
                ),
              ),
              SizedBox(height: 6.h),
            ],

            Listener(
              onPointerDown: (event) {
                if (!mounted) return;
                if (_isDropdownOpen) {
                  final RenderBox renderBox =
                      _dropdownKey.currentContext?.findRenderObject()
                          as RenderBox;
                  final offset = renderBox.localToGlobal(Offset.zero);
                  final size = renderBox.size;

                  final tapPosition = event.position;
                  if (tapPosition.dx < offset.dx ||
                      tapPosition.dx > offset.dx + size.width ||
                      tapPosition.dy < offset.dy ||
                      tapPosition.dy > offset.dy + size.height) {
                    closeDropdown();
                  }
                }
              },
              child: Container(
                key: _dropdownKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Dropdown Trigger
                    GestureDetector(
                      onTap: isLoading ? null : _toggleDropdown,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _isDropdownOpen
                                ? AppColors.primaryColor
                                : AppColors.authUnderlineBorderColor,
                            width: _isDropdownOpen ? 2.w : 1.w,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                isLoading
                                    ? 'Loading...'
                                    : _selectedEmployees.isEmpty
                                    ? 'Select assigned person'
                                    : _selectedEmployees
                                          .map((e) => e.empName)
                                          .join(', '),
                                style: GoogleFonts.sora(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.titleColor.withOpacity(
                                    isLoading ? 0.4 : 1.0,
                                  ),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            AnimatedRotation(
                              turns: _isDropdownOpen ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: isLoading
                                    ? AppColors.titleColor.withOpacity(0.4)
                                    : AppColors.titleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 🔹 Dropdown Content
                    if (!isLoading)
                      ScaleTransition(
                        scale: _scaleAnimation,
                        alignment: Alignment.topCenter,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _isDropdownOpen
                              ? Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.authUnderlineBorderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  constraints: BoxConstraints(maxHeight: 250.h),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: employees.map((emp) {
                                        final isSelected = _selectedEmployees
                                            .contains(emp);
                                        return CheckboxListTile(
                                          title: Text(
                                            emp.empName,
                                            style: GoogleFonts.sora(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.titleColor,
                                            ),
                                          ),
                                          subtitle: Text(
                                            'Employee ID: ${emp.empId}',
                                            style: GoogleFonts.sora(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.titleColor
                                                  .withOpacity(0.6),
                                            ),
                                          ),
                                          value: isSelected,
                                          onChanged: (value) => _onItemSelected(
                                            emp,
                                            value ?? false,
                                          ),
                                          activeColor: AppColors.primaryColor,
                                          checkColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                            vertical: 2.h,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
