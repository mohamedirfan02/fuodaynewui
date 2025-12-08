import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/providers/checkbox_provider.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/models/notification_model.dart';
import 'package:fuoday/core/providers/app_file_downloader_provider.dart';
import 'package:fuoday/core/providers/app_file_picker_provider.dart';
import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/core/router/app_router.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/themes/provider/theme_provider.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/draft_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_absent_days_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_attendance_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_early_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_late_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_punctual_arrivals_details_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_login_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_logout_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/sliding_segmented_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/bottom_nav_provider.dart';
import 'package:fuoday/features/calendar/presentation/providers/shift_schedule_provider.dart';
import 'package:fuoday/features/home/presentation/provider/all_events_provider.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/home/presentation/provider/recognition_provider.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/hr/presentation/provider/total_payroll_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/all_regulations_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/update_leave_status_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/update_regulation_status_provider.dart';
import 'package:fuoday/features/organizations/domain/usecase/GetDepartmentListUseCase.dart';
import 'package:fuoday/features/organizations/domain/usecase/ser_ind_usecase.dart';
import 'package:fuoday/features/organizations/presentation/providers/DepartmentListProvider.dart';
import 'package:fuoday/features/organizations/presentation/providers/organization_about_provider.dart';
import 'package:fuoday/features/organizations/presentation/providers/services_and_industries_provider.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_about.dart';
import 'package:fuoday/features/payslip/presentation/Provider/payroll_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/audit_report_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_form_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/performance_summary_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/rating_provider.dart';
import 'package:fuoday/features/profile/presentation/providers/profile_edit_provider.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';
import 'package:fuoday/features/support/domain/usecase/get_ticket_details_usecase.dart';
import 'package:fuoday/features/support/persentation/provider/get_ticket_details_provider.dart';
import 'package:fuoday/features/support/persentation/provider/ticket_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_leave_requests_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_role_total_attendance_report_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/late_arrivals_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/role_based_users_provider.dart';
import 'package:fuoday/features/team_tree/presentation/provider/team_tree_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_members_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_project_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_reportees_provider.dart';
import 'package:fuoday/features/time_tracker/domain/usecase/get_time_and_project_tracker_UseCase.dart';
import 'package:fuoday/features/time_tracker/presentation/provider/time_tracker_provider.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/ats_candidate/presentation/provider/candidate_action_provider.dart';
import 'features/ats_candidate/presentation/provider/candidates_provider.dart';
import 'features/attendance/presentation/providers/date_time_provider.dart';
import 'features/bottom_nav/providers/recruiter_bottom_nav_provider.dart';
import 'features/home/presentation/provider/badge_provider.dart';
import 'features/home/presentation/provider/checkin_status_provider.dart';
import 'features/home/presentation/provider/employee_department_provider.dart';
import 'features/leave_tracker/presentation/providers/leave_regulation_provider.dart';
import 'features/management/presentation/provider/emp_audit_form_provider.dart';
import 'features/payslip/presentation/Provider/payroll_overview_provider.dart';
import 'features/performance/presentation/providers/audit_reporting_team_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void commonMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  // App Api Environment Check
  AppLoggerHelper.logInfo(
    'App Environment Url Check: ${AppApiEndpointConstants.baseUrl}',
  );

  // Hive init
  await Hive.initFlutter();

  // ===== IMPORTANT: Register Adapter BEFORE opening boxes =====
  if (!Hive.isAdapterRegistered(5)) {
    Hive.registerAdapter(NotificationModelAdapter());
  }

  // Hive Open Boxes
  await Hive.openBox(AppHiveStorageConstants.apiCacheBox);
  await Hive.openBox(AppHiveStorageConstants.authBoxKey);
  await Hive.openBox(AppHiveStorageConstants.onBoardingBoxKey);
  await Hive.openBox(AppHiveStorageConstants.employeeDetailsBoxKey);
  await Hive.openBox(AppHiveStorageConstants.themeBoxKey);
  // Open notifications box with type
  await Hive.openBox<NotificationModel>(
    AppHiveStorageConstants.notificationsBoxKey,
  );

  // dependency injection
  setUpServiceLocator();

  // Initialize hive service
  await getIt<HiveStorageService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Bottom Nav Provider
        ChangeNotifierProvider(create: (context) => getIt<BottomNavProvider>()),

        ChangeNotifierProvider(
          create: (context) => getIt<RecruiterBottomNavProvider>(),
        ),

        // Sliding Segmented Provider
        ChangeNotifierProvider(
          create: (context) => getIt<SlidingSegmentedProvider>(),
        ),

        // Drop Down Provider
        ChangeNotifierProvider(create: (context) => getIt<DropdownProvider>()),

        // App Theme Provider
        ChangeNotifierProvider(create: (context) => getIt<ThemeProvider>()),

        // Check Box Provider
        ChangeNotifierProvider(create: (context) => getIt<CheckboxProvider>()),

        // Profile Edit Provider
        ChangeNotifierProvider(
          create: (context) => getIt<ProfileEditProvider>(),
        ),

        // App File Picker Provider
        ChangeNotifierProvider(
          create: (context) => getIt<AppFilePickerProvider>(),
        ),

        // Check In Provider
        ChangeNotifierProvider(create: (context) => getIt<CheckInProvider>()),

        // App File Downloader Provider
        ChangeNotifierProvider(
          create: (context) => getIt<AppFileDownloaderProvider>(),
        ),

        // Employee Auth Login Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuthLoginProvider>(),
        ),

        // Employee Auth Logout Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuthLogoutProvider>(),
        ),

        // All Events Provider
        ChangeNotifierProvider(create: (context) => getIt<AllEventsProvider>()),

        // Shift Schedule Provider
        ChangeNotifierProvider(
          create: (context) => getIt<ShiftScheduleProvider>(),
        ),

        // Team Members Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamMembersProvider>(),
        ),

        // Team Project Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamProjectProvider>(),
        ),

        // Team Reportee Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TeamReporteesProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => TimeTrackerProvider(
            usecase: getIt<GetTimeAndProjectTrackerUseCase>(),
          ),
          child: TimeTrackerScreen(),
        ),

        // Total Attendance Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalAttendanceDetailsProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => getIt<OrganizationAboutProvider>(),
          child: const OrganizationsAbout(),
        ),

        //Organization Services and industries
        ChangeNotifierProvider(
          create: (_) => ServicesAndIndustriesProvider(
            getServicesAndIndustriesUseCase:
                getIt<GetServicesAndIndustriesUseCase>(),
          ),
        ),

        //Organization Dept TeamList
        ChangeNotifierProvider(
          create: (_) => DepartmentListProvider(
            getDepartmentListUseCase: getIt<GetDepartmentListUseCase>(),
          ),
        ),

        // Total Late Arrivals Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalLateArrivalsDetailsProvider>(),
        ),

        // Total Early Arrivals Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalEarlyArrivalsDetailsProvider>(),
        ),

        // Total Absent Days Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalAbsentDaysDetailsProvider>(),
        ),

        // Total Punctual Details Provider
        ChangeNotifierProvider(
          create: (context) => getIt<TotalPunctualArrivalDetailsProvider>(),
        ),

        //create ticket
        ChangeNotifierProvider(
          create: (context) => TicketProvider(getIt<CreateTicketUseCase>()),
        ),

        //get ticket details
        ChangeNotifierProvider(
          create: (context) =>
              GetTicketDetailsProvider(getIt<GetTicketDetailsUseCase>()),
        ),

        // Performance Summary Provider
        ChangeNotifierProvider(
          create: (context) => getIt<PerformanceSummaryProvider>(),
        ),

        // Employee Audit Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuditProvider>(),
        ),

        // Employee Audit Form Provider
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeAuditFormProvider>(),
        ),

        // Rating Provider
        ChangeNotifierProvider(create: (context) => RatingProvider()),

        // App Internet Checker Provider
        ChangeNotifierProvider(
          create: (context) => AppInternetCheckerProvider(),
        ),

        // Payroll Provider
        ChangeNotifierProvider(create: (context) => getIt<PayrollProvider>()),
        // Payroll Overview Provider
        ChangeNotifierProvider(
          create: (context) => getIt<PayrollOverviewProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<EmpAuditFormProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<LeaveRegulationProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<AuditReportingTeamProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<CheckinStatusProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<AuditReportProvider>(),
        ),

        ChangeNotifierProvider(create: (context) => getIt<TeamTreeProvider>()),

        ChangeNotifierProvider(
          create: (context) => getIt<RecognitionProvider>(),
        ),
        ChangeNotifierProvider(create: (context) => getIt<BadgeProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<DateTimeProvider>()),
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeDepartmentProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<ForgotPasswordProvider>(),
        ),
        ChangeNotifierProvider(create: (context) => getIt<VerifyOtpProvider>()),
        ChangeNotifierProvider(
          create: (context) => getIt<ResetPasswordProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<RoleBasedUsersProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<AttendanceReportProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<LateArrivalsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<AllLeaveRequestsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<UpdateLeaveStatusProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<AllRegulationsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<UpdateRegulationStatusProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<TotalPayrollProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<HROverviewProvider>(),
        ),
        //===============ATS PAGES====================================
        ChangeNotifierProvider(
          create: (context) => getIt<CandidatesProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => getIt<CandidateActionProvider>(),
        ),
        //Draft provider In Candidate Screen
        ChangeNotifierProvider(create: (context) => getIt<DraftProvider>()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Detect device type and orientation
          final isTablet = constraints.maxWidth > 600;
          final isLandscape = constraints.maxWidth > constraints.maxHeight;

          // Define design size based on device type
          final designSize = isTablet
              ? (isLandscape
                    ? const Size(1194, 834) // Tablet landscape
                    : const Size(834, 1194)) // Tablet portrait
              : const Size(360, 690); // Mobile design
          return ScreenUtilInit(
            //designSize: const Size(360, 690),
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    title: AppEnvironment.environmentName == "DEV"
                        ? "Fuoday Dev"
                        : "Fuoday",
                    // theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeProvider.themeMode, // theme: ThemeData(
                    //   textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
                    // ),
                    routerConfig: appRouter,
                    builder: (context, child) {
                      return Banner(
                        message: AppEnvironment.environmentName,
                        location: BannerLocation.topEnd,
                        color: AppEnvironment.environmentName == "DEV"
                            ? AppColors.checkOutColor
                            : AppColors.checkInColor,
                        textStyle: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                          letterSpacing: 1.0,
                        ),
                        child: child!,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
