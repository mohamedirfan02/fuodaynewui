import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_dropdown/flutter_multi_select_dropdown.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/emp_department_entity.dart';
import '../provider/employee_department_provider.dart';

class EmployeeDepartmentDropdownCheckbox extends StatefulWidget {
  final Function(List<EmployeeModelEntity>)? onSelectionChanged;

  const EmployeeDepartmentDropdownCheckbox({
    super.key,
    this.onSelectionChanged,
  });

  @override
  State<EmployeeDepartmentDropdownCheckbox> createState() =>
      _EmployeeDepartmentDropdownCheckboxState();
}

class _EmployeeDepartmentDropdownCheckboxState
    extends State<EmployeeDepartmentDropdownCheckbox> {
  final List<EmployeeModelEntity> _selectedEmployees = [];
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
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

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _closeDropdown() {
    if (_isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
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

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(_selectedEmployees);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDepartmentProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading)
          return const Center(child: CircularProgressIndicator());
        if (provider.errorMessage != null)
          return Center(child: Text(provider.errorMessage!));

        final empDept = provider.employeeDepartment;
        if (empDept == null || empDept.sameDepartment.isEmpty) {
          return const Center(child: Text('No employees found.'));
        }

        final employees = empDept.sameDepartment;

        return Stack(
          children: [
            // Detect taps outside dropdown
            if (_isDropdownOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDropdown,
                  behavior: HitTestBehavior.translucent,
                  child: Container(),
                ),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _toggleDropdown,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _selectedEmployees.isEmpty
                                ? 'Select assigned person'
                                : _selectedEmployees
                                      .map((e) => e.empName)
                                      .join(', '),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          _isDropdownOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isDropdownOpen)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade100,
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: SingleChildScrollView(
                      child: Column(
                        children: employees.map((emp) {
                          final isSelected = _selectedEmployees.contains(emp);
                          return CheckboxListTile(
                            title: Text(emp.empName),
                            subtitle: Text('Department: ${emp.department}'),
                            value: isSelected,
                            onChanged: (value) =>
                                _onItemSelected(emp, value ?? false),
                            activeColor: Colors.green,
                            contentPadding: EdgeInsets.zero,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
