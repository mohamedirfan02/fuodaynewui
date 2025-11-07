import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/management/domain/entities/emp_audit_form_entity.dart';
import 'package:fuoday/features/management/presentation/provider/emp_audit_form_provider.dart';
import 'package:fuoday/features/management/presentation/screens/management_overview.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_open_positions.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_projects.dart';
import 'package:fuoday/features/management/presentation/screens/management_view_recent_employees.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize the audit form provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hiveService = getIt<HiveStorageService>();
      final employeeDetails = hiveService.employeeDetails;
      final webUserId =
          int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '0') ?? 0;

      // Access the global provider and fetch data
      context.read<EmpAuditFormProvider>().fetchEmployeesByManagers(webUserId);
    });
  }

  Future<void> _launchManagementDashboard() async {
    final url = Uri.parse("https://fuoday.com/login");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  // Table columns for the employee data
  final columns = [
    'S.No',
    'Emp Id',
    'Name',
    'Date of join',
    'Designation',
    'Status',
    'Actions',
  ];

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = getIt<HROverviewProvider>();
            final webUserId =
                int.tryParse(
                  employeeDetails?['web_user_id']?.toString() ?? '0',
                ) ??
                0;
            provider.fetchHROverview(webUserId);
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final provider = getIt<EmpAuditFormProvider>();
            final webUserId =
                int.tryParse(
                  employeeDetails?['web_user_id']?.toString() ?? '0',
                ) ??
                0;
            provider.fetchEmployeesByManagers(webUserId);
            return provider;
          },
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: KAppBar(
            title: "Management Dashboard",
            centerTitle: true,
            leadingIcon: Icons.arrow_back,
            onLeadingIconPress: () {
              GoRouter.of(context).pop();
            },
          ),
          bottomNavigationBar: Container(
            height: 60.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: KAuthFilledBtn(
                backgroundColor: AppColors.primaryColor,
                height: AppResponsive.responsiveBtnHeight(context),
                width: double.infinity,
                text: "View Audit Process",
                onPressed: () {
                  _showAuditProcessModal(context);
                },
                fontSize: 11.sp,
              ),
            ),
          ),
          body: Consumer<HROverviewProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.error != null) {
                return Center(child: Text('Error: ${provider.error}'));
              } else if (provider.hrOverview == null) {
                return const Center(child: Text('No data found.'));
              }
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Image
                    KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),
                    KVerticalSpacer(height: 24.h),

                    // Person Card
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.greyColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppColors.cardGradientColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          KText(
                            text: name,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: "Designation: $designation",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: "Employee id: $empId",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: email,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),

                    KVerticalSpacer(height: 30.h),

                    KTabBar(
                      tabs: [
                        Tab(text: "Projects"),
                        Tab(text: "Recent Employees"),
                        Tab(text: "Open Positions"),
                      ],
                    ),

                    KVerticalSpacer(height: 20.h),

                    Expanded(
                      child: TabBarView(
                        children: [
                          ManagementViewProjects(),
                          ManagementViewRecentEmployees(
                            hrOverview: provider.hrOverview!,
                          ),
                          ManagementViewOpenPositions(
                            hrOverview: provider.hrOverview!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAuditProcessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            top: 10.h,
          ),
          child: Consumer<EmpAuditFormProvider>(
            builder: (context, empAuditProvider, _) {
              if (empAuditProvider.isLoading) {
                return SizedBox(
                  height: 300.h,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (empAuditProvider.error != null) {
                return SizedBox(
                  height: 300.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${empAuditProvider.error}'),
                        ElevatedButton(
                          onPressed: () {
                            final hiveService = getIt<HiveStorageService>();
                            final employeeDetails = hiveService.employeeDetails;
                            final webUserId =
                                int.tryParse(
                                  employeeDetails?['web_user_id']?.toString() ??
                                      '0',
                                ) ??
                                0;
                            empAuditProvider.fetchEmployeesByManagers(
                              webUserId,
                            );
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 2.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),

                    KVerticalSpacer(height: 20.h),

                    // Statistics
                    _buildStatisticsCard(empAuditProvider),

                    KVerticalSpacer(height: 20.h),

                    // Display managers with their employees
                    ...empAuditProvider.managersWithEmployees.map((manager) {
                      return _buildManagerSection(manager);
                    }).toList(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatisticsCard(EmpAuditFormProvider provider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Total", provider.totalEmployees.toString()),
          _buildStatItem("Submitted", provider.submittedCount.toString()),
          _buildStatItem("Pending", provider.notSubmittedCount.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        KText(
          text: value,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: AppColors.primaryColor,
        ),
        KText(
          text: label,
          fontSize: 12.sp,
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildManagerSection(ManagerWithEmployeesEntity manager) {
    final tableData = manager.employees.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final employee = entry.value;

      return {
        'S.No': index.toString(),
        'Emp Id': employee.empId,
        'Name': employee.empName,
        'Date of join': employee.doj,
        'Designation': employee.designation,
        'Status': Text(
          employee.status,
          style: TextStyle(
            color: employee.isSubmitted ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        'Actions': ElevatedButton(
          onPressed: _launchManagementDashboard,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            textStyle: TextStyle(fontSize: 10.sp),
          ),
          child: KText(
            text: 'View',
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColor,
            fontSize: 14.sp,
          ),
        ),
      };
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: manager.managerName,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: AppColors.primaryColor,
        ),
        KVerticalSpacer(height: 10.h),
        if (manager.employees.isNotEmpty)
          SizedBox(
            height: 200.h,
            child: KDataTable(columnTitles: columns, rowData: tableData),
          )
        else
          Container(
            height: 60.h,
            alignment: Alignment.center,
            child: KText(
              text: "No employees found",
              fontSize: 12.sp,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        KVerticalSpacer(height: 20.h),
      ],
    );
  }
}
