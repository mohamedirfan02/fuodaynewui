import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/profile/domain/entities/employee_profile_entity.dart';
import 'package:fuoday/features/profile/domain/usecases/get_employee_profile_usecase.dart';
import 'package:go_router/go_router.dart';

class ProfileEmploymentDetailsScreen extends StatefulWidget {
  const ProfileEmploymentDetailsScreen({super.key});

  @override
  State<ProfileEmploymentDetailsScreen> createState() =>
      _ProfileEmploymentDetailsScreenState();
}

class _ProfileEmploymentDetailsScreenState
    extends State<ProfileEmploymentDetailsScreen> {
  // form key
  final formKey = GlobalKey<FormState>();
  EmployeeProfileEntity? profileData;

  // controllers
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController jobRoleController = TextEditingController();
  final TextEditingController dateOfJoinController = TextEditingController();
  final TextEditingController reportingManagerController =
      TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final getEmployeeProfileUseCase = getIt<GetEmployeeProfileUseCase>();

  @override
  void initState() {
    super.initState();
    fetchEmploymentData();
  }

  Future<void> fetchEmploymentData() async {
    try {
      final employeeData = getIt<HiveStorageService>().employeeDetails;
      AppLoggerHelper.logInfo("🧠 employeeDetails from Hive: $employeeData");

      final userId = employeeData?['web_user_id']?.toString();
      AppLoggerHelper.logInfo("🆔 Extracted webUserId: $userId");

      if (userId == null || userId == 'null') {
        AppLoggerHelper.logError("❗ webUserId is missing — aborting API call.");
        return;
      }

      final profile = await getEmployeeProfileUseCase.execute(userId);

      setState(() {
        profileData = profile;
        departmentController.text = profile.department;
        jobRoleController.text = profile.designation;
        dateOfJoinController.text = profile.dateOfJoining;
        reportingManagerController.text = profile.reportingManagerName;
        employeeIdController.text = profile.empId;
      });
    } catch (e) {
      AppLoggerHelper.logError("Employment fetch error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Employment Details",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            spacing: 14.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Department
              KAuthTextFormField(
                controller: departmentController,
                label: "Department",
                hintText: "Department",
                suffixIcon: Icons.person_outline,
                isReadOnly: true,
              ),

              // Department
              KAuthTextFormField(
                controller: jobRoleController,
                label: "Job Role",
                hintText: "Job Role",
                suffixIcon: Icons.location_city,
                isReadOnly: true,
              ),

              // Date of join
              KAuthTextFormField(
                controller: dateOfJoinController,
                label: "Date of join",
                hintText: "Date of join",
                suffixIcon: Icons.calendar_month_outlined,
                isReadOnly: true,
              ),

              // Reporting Manager
              KAuthTextFormField(
                controller: reportingManagerController,
                label: "Reporting Manager",
                hintText: "Reporting Manager",
                suffixIcon: Icons.manage_accounts_rounded,
                isReadOnly: true,
              ),

              // Reporting Manager
              KAuthTextFormField(
                controller: employeeIdController,
                label: "Employee Id",
                hintText: "Employee Id",
                suffixIcon: Icons.important_devices,
                isReadOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
