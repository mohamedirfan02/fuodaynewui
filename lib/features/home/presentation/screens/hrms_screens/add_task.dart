import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/domain/entities/home_addtask_entity.dart';
import 'package:fuoday/features/home/domain/usecases/emp_list_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/home_addtask_usecase.dart';
import 'package:fuoday/features/home/presentation/widgets/assigned_person_dropdown.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/emp_department_entity.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // Form Key
  final formKey = GlobalKey<FormState>();
  DateTime? assignDate;
  DateTime selectedDeadline = DateTime.now();

  // Add this key to control the dropdown
  final GlobalKey<AssignedPersonDropdownCheckboxState> dropdownKey =
      GlobalKey<AssignedPersonDropdownCheckboxState>();

  // Controllers
  final TextEditingController assignedByController = TextEditingController();
  final TextEditingController assignDateController = TextEditingController();
  final TextEditingController assignedToController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  String selectedPriority = 'High';
  String assignedByName = 'Irfan'; // Set accordingly
  int webUserId = 0;

  @override
  void dispose() {
    assignedByController.dispose();
    assignDateController.dispose();
    assignedToController.dispose();
    projectNameController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  List<EmployeeModelEntity> selectedEmployees = [];
  List<EmployeeModel> employees = [];
  String? selectedEmployeeName;
  String? selectedEmployeeId;

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Dynamically get web_user_id
    final int id = int.tryParse(employeeDetails?['id']?.toString() ?? '') ?? 0;

    if (id == 0) {
      print("❌ Invalid or missing id from Hive");
      return;
    }

    final useCase = getIt<FetchEmployeesUseCase>();
    final result = await useCase(id.toString());

    setState(() {
      employees = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Select Date
    Future<void> selectDate(
      BuildContext context,
      TextEditingController controller, {
      required bool isDeadline,
      required bool isAssignDate,
    }) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.day,
        helpText: 'Select Date',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.secondaryColor,
                onSurface: AppColors.titleColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);

        if (isDeadline) {
          setState(() {
            selectedDeadline = picked;
          });
        }
        if (isAssignDate) {
          setState(() {
            assignDate = picked;
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Assigned By Text Field
                KAuthTextFormField(
                  label: "Assigned By",
                  controller: assignedByController,
                  hintText: "Enter assigned by",
                  keyboardType: TextInputType.text,
                ),

                KVerticalSpacer(height: 20.h),

                // Assign By Date
                KAuthTextFormField(
                  label: "Assign Date",
                  onTap: () async {
                    await selectDate(
                      context,
                      assignDateController,
                      isDeadline: false,
                      isAssignDate: true,
                    );
                  },
                  controller: assignDateController,
                  hintText: "Select assign date",
                  keyboardType: TextInputType.datetime,
                  suffixIcon: Icons.date_range,
                ),

                KVerticalSpacer(height: 20.h),

                KText(
                  text: "Assigned Person",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),

                KVerticalSpacer(height: 6.h),

                // Assigned To Person Text Field
                // KDropdownTextFormField<String>(
                //   hintText: "Select assigned person",
                //   value: selectedEmployeeName,
                //   items: employees.map((e) => e.name).toList(), // Changed from empName to name
                //   onChanged: (value) {
                //     final selected = employees.firstWhere(
                //           (e) => e.name == value, // Changed from empName to name
                //     );
                //     setState(() {
                //       selectedEmployeeName = selected.name; // Changed from empName to name
                //       selectedEmployeeId = selected.id.toString(); // Changed from webUserId to id
                //     });
                //   },
                // ),
                // EmployeeDepartmentDropdown(
                //   // example manager ID
                //   onSelectionChanged: (selectedEmployees) {
                //     // 🔹 You can access selected employee data here
                //     for (final emp in selectedEmployees) {
                //       debugPrint(
                //         'You selected: ${emp.empName} (${emp.department})',
                //       );
                //     }
                //   },
                // ),
                // Assigned To Person Dropdown Checkbox
                AssignedPersonDropdownCheckbox(
                  key: dropdownKey,
                  onSelectionChanged: (employees) {
                    selectedEmployees = employees;
                    List<String> selectedNames = employees
                        .map((e) => e.empName ?? '')
                        .toList();

                    //   CHANGE #2: Convert that list into a single string like "Yousuf","Mohamed","Malik"
                    String namesString = selectedNames
                        .map((name) => '"$name"')
                        .join(',');

                    //   CHANGE #3: Print for debugging
                    print('Selected Employee Names: $namesString');

                    //   (Optional) if you want to keep printing all employee objects for debugging
                    print('All Employee Objects: $employees');
                  },
                ),

                KVerticalSpacer(height: 20.h),

                // Project Name
                KAuthTextFormField(
                  label: "Project Name",
                  controller: projectNameController,
                  hintText: "Enter project name",
                  keyboardType: TextInputType.text,
                  onTap: () {
                    dropdownKey.currentState?.closeDropdown();
                  },
                ),

                KVerticalSpacer(height: 20.h),

                // Description
                KAuthTextFormField(
                  maxLines: 5,
                  label: "Description",
                  controller: descriptionController,
                  hintText: "Enter description",
                  keyboardType: TextInputType.text,
                ),

                KVerticalSpacer(height: 20.h),

                KText(
                  text: "Priority",
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),

                KVerticalSpacer(height: 6.h),

                // Priority
                KDropdownTextFormField<String>(
                  hintText: "Priority",
                  value: context.dropDownProviderWatch.getValue('priority'),
                  items: ['High', 'Medium', 'Low'],
                  onChanged: (value) =>
                      context.dropDownProviderRead.setValue('priority', value),
                ),

                KVerticalSpacer(height: 20.h),

                // Deadline
                KAuthTextFormField(
                  label: "Deadline",
                  onTap: () async {
                    await selectDate(
                      context,
                      deadlineController,
                      isDeadline: true,
                      isAssignDate: false,
                    );
                  },
                  controller: deadlineController,
                  hintText: "Select Deadline",
                  keyboardType: TextInputType.datetime,
                  suffixIcon: Icons.date_range,
                ),

                KVerticalSpacer(height: 30),

                // Create Task
                KAuthFilledBtn(
                  // isLoading: ,
                  text: "Create Task",

                  // onPressed: () async {
                  //   //Immediately close dropdown (even before validation)
                  //   dropdownKey.currentState?.closeDropdown();
                  //   if (formKey.currentState!.validate()) {
                  //     final hiveService = GetIt.I<HiveStorageService>();
                  //     final webUserId = hiveService
                  //         .employeeDetails?['web_user_id']
                  //         ?.toString();
                  //     final assignedToName = selectedEmployeeName;
                  //     final assignedToId = selectedEmployeeId;
                  //     final priority = context.dropDownProviderRead.getValue(
                  //       'priority',
                  //     );
                  //
                  //     final assignedByName = assignedByController.text
                  //         .trim(); // <-- get dynamic name
                  //
                  //     if (webUserId == null ||
                  //         assignedToName == null ||
                  //         assignedToId == null ||
                  //         priority == null ||
                  //         assignedByName.isEmpty) {
                  //       KSnackBar.failure(
                  //         context,
                  //         'Missing required information',
                  //       );
                  //       return;
                  //     }
                  //     //   Check selected employees
                  //     if (webUserId == null ||
                  //         selectedEmployees.isEmpty ||
                  //         priority == null ||
                  //         assignedByName.isEmpty) {
                  //       KSnackBar.failure(
                  //         context,
                  //         'Missing required information',
                  //       );
                  //       return;
                  //     }
                  //
                  //     // If multiple employees selected, you can choose first or send as comma separated
                  //     final assignedToName2 = selectedEmployees
                  //         .map((e) => e.empName)
                  //         .join(', ');
                  //     final assignedToId2 = selectedEmployees.first
                  //         .toString(); // or handle multiple
                  //
                  //     final taskEntity = HomeAddTaskEntity(
                  //       webUserId: int.parse(webUserId),
                  //       date: DateFormat(
                  //         'yyyy-MM-dd',
                  //       ).format(assignDate ?? DateTime.now()),
                  //       description: descriptionController.text.trim(),
                  //       assignedBy: assignedByName,
                  //       assignedById: int.parse(webUserId),
                  //       assignedTo: assignedToName,
                  //       assignedToId: int.parse(assignedToId),
                  //       priority: priority,
                  //       deadline: DateFormat(
                  //         'yyyy-MM-dd',
                  //       ).format(selectedDeadline),
                  //       project: projectNameController.text.trim(),
                  //     );
                  //
                  //     try {
                  //       final usecase = GetIt.I<HomeAddTaskUseCase>();
                  //       await usecase(taskEntity, webUserId);
                  //       KSnackBar.success(
                  //         context,
                  //         'Task assigned successfully',
                  //       );
                  //       // Clear dropdown selections (after success)
                  //       dropdownKey.currentState?.clearSelection();
                  //
                  //       //   Clear all fields
                  //       formKey.currentState!.reset();
                  //       assignedByController.clear();
                  //       assignDateController.clear();
                  //       assignedToController.clear();
                  //       projectNameController.clear();
                  //       descriptionController.clear();
                  //       priorityController.clear();
                  //       deadlineController.clear();
                  //
                  //       setState(() {
                  //         selectedEmployeeName = null;
                  //         selectedEmployeeId = null;
                  //         selectedDeadline = DateTime.now();
                  //         context.dropDownProviderRead.setValue(
                  //           'priority',
                  //           null,
                  //         );
                  //       });
                  //     } catch (e) {
                  //       KSnackBar.failure(context, 'Failed to assign task: $e');
                  //     }
                  //   }
                  // },
                  onPressed: () async {
                    //  CAPTURE VALUES IMMEDIATELY at the start
                    final namesString = selectedEmployees
                        .map((e) => e.empName)
                        .join(', ');

                    final idsString = selectedEmployees
                        .map((e) => e.webUserId.toString())
                        .join(',');

                    print("🔵 Captured Names: $namesString");
                    print("🔵 Captured IDs: $idsString");
                    //Immediately close dropdown (even before validation)
                    dropdownKey.currentState?.closeDropdown();

                    if (formKey.currentState!.validate()) {
                      final hiveService = GetIt.I<HiveStorageService>();
                      final webUserId = hiveService
                          .employeeDetails?['web_user_id']
                          ?.toString();
                      final priority = context.dropDownProviderRead.getValue(
                        'priority',
                      );
                      final assignedByName = assignedByController.text.trim();

                      if (webUserId == null ||
                          selectedEmployees.isEmpty ||
                          priority == null ||
                          assignedByName.isEmpty) {
                        KSnackBar.failure(
                          context,
                          'Missing required information',
                        );
                        return;
                      }

                      print("🟢 Using Names: $namesString");
                      print("🟢 Using IDs: $idsString");
                      // e.g. "1005,1006"

                      final taskEntity = HomeAddTaskEntity(
                        webUserId: int.parse(webUserId),
                        date: DateFormat(
                          'yyyy-MM-dd',
                        ).format(assignDate ?? DateTime.now()),
                        description: descriptionController.text.trim(),
                        assignedBy: assignedByName,
                        assignedById: int.parse(webUserId),
                        assignedTo: namesString, //   changed here!
                        // assignedToId: int.parse(
                        //   selectedEmployees.first.empId.toString(),
                        // ),
                        assignedToId: idsString,
                        priority: priority,
                        deadline: DateFormat(
                          'yyyy-MM-dd',
                        ).format(selectedDeadline),
                        project: projectNameController.text.trim(),
                      );

                      try {
                        final usecase = GetIt.I<HomeAddTaskUseCase>();
                        await usecase(taskEntity, webUserId);
                        KSnackBar.success(
                          context,
                          'Task assigned successfully',
                        );

                        // Clear dropdown selections
                        dropdownKey.currentState?.clearSelection();

                        //   Clear all fields
                        formKey.currentState!.reset();
                        assignedByController.clear();
                        assignDateController.clear();
                        assignedToController.clear();
                        projectNameController.clear();
                        descriptionController.clear();
                        priorityController.clear();
                        deadlineController.clear();

                        setState(() {
                          selectedEmployeeName = null;
                          selectedEmployeeId = null;
                          selectedDeadline = DateTime.now();
                          context.dropDownProviderRead.setValue(
                            'priority',
                            null,
                          );
                        });
                      } catch (e) {
                        KSnackBar.failure(context, 'Failed to assign task: $e');
                      }
                    }
                  },

                  backgroundColor: AppColors.primaryColor,
                  fontSize: 10.sp,
                  height: AppResponsive.responsiveBtnHeight(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
