import 'package:flutter/cupertino.dart';
import 'package:fuoday/common_main.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/approval/presentation/screens/approval_screen.dart';
import 'package:fuoday/features/ats_admin_tab/presentation/screens/ats_admin_tabs_screen.dart';
import 'package:fuoday/features/ats_calender/presentation/screen/ats_calender_screen.dart';
import 'package:fuoday/features/ats_candidate/presentation/screens/ats_candidates_application_view_screen.dart';
import 'package:fuoday/features/ats_candidate/presentation/screens/ats_schedule_interview_screen.dart';
import 'package:fuoday/features/ats_candidate/presentation/screens/candidate_screen.dart';
import 'package:fuoday/features/ats_candidate/presentation/screens/ats_draft_screen.dart';
import 'package:fuoday/features/ats_help_center_screen/presentation/screens/ats_help_center_screen.dart';
import 'package:fuoday/features/ats_hiring/presentation/screens/hiring_screen.dart';
import 'package:fuoday/features/ats_index/presentation/screen/ats_index_screen.dart';
import 'package:fuoday/features/ats_job_portal/presentation/screen/ats_job_portal_screen.dart';
import 'package:fuoday/features/ats_settings/presentation/screens/ats_settings_screen.dart';
import 'package:fuoday/features/ats_support/presentation/screens/ats_support_screen.dart';
import 'package:fuoday/features/ats_support/presentation/screens/new_ticket_screen.dart';
import 'package:fuoday/features/ats_support/presentation/screens/support_myticket_screen_tab.dart';
import 'package:fuoday/features/ats_tracker/presentation/screens/ats_tracker_interview.dart';
import 'package:fuoday/features/ats_tracker/presentation/screens/ats_tracker_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_absent_days_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_early_arrivals_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_late_arrival_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_punctual_arrival_details_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:fuoday/features/attendance/presentation/screens/total_attendance_view_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_forget_password_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/auth_otp_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/privacy_policy_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:fuoday/features/auth/presentation/screens/terms_of_service_screen.dart';
import 'package:fuoday/features/bottom_nav/presentation/employee_bottom_nav.dart';
import 'package:fuoday/features/bottom_nav/presentation/recruiter_bottom_nav.dart';
import 'package:fuoday/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:fuoday/features/feeds/presentation/screens/feeds_screen.dart';
import 'package:fuoday/features/ats_candidate/presentation/screens/ats_candidate_information_screen.dart';
import 'package:fuoday/features/home/presentation/screens/hrms_screens/home_employee_screen.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/home_recruiter_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/he_regulation_approval_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_permission_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_total_attendance_report_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_total_employees_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_total_late_arrival_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_total_leave_request_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_total_payroll_screen.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_screen.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_tracker_screen.dart';
import 'package:fuoday/features/management/presentation/screens/management_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/manager_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_feed_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_late_arrival_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_regulation_aproval_screens.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_total_attendace_report_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_total_employees_screen.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_total_leave_request_screen.dart';
import 'package:fuoday/features/notification/presentation/screens/notification_screen.dart';
import 'package:fuoday/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_screen.dart';
import 'package:fuoday/features/payslip/presentation/screens/pay_slip_screen.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_screen.dart';
import 'package:fuoday/features/previews/presentation/screens/image_preview_screen.dart';
import 'package:fuoday/features/previews/presentation/screens/pdf_preview_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_educational_background_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_employment_details_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_on_boarding_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_personal_details_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_professional_experience_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_screen.dart';
import 'package:fuoday/features/splash/presentation/screens/splash_screen.dart';
import 'package:fuoday/features/support/persentation/screens/support_screen.dart';
import 'package:fuoday/features/team_leader/presentation/screens/sub_screens/TL_late_arrival_screen.dart';
import 'package:fuoday/features/team_leader/presentation/screens/sub_screens/TL_regulation_aproval_screens.dart';
import 'package:fuoday/features/team_leader/presentation/screens/sub_screens/TL_total_attendace_report_screen.dart';
import 'package:fuoday/features/team_leader/presentation/screens/sub_screens/TL_total_employees_screen.dart';
import 'package:fuoday/features/team_leader/presentation/screens/sub_screens/TL_total_leave_request_screen.dart';
import 'package:fuoday/features/team_leader/presentation/screens/team_leader_screen.dart';
import 'package:fuoday/features/team_tree/presentation/screens/team_tree_screen.dart';
import 'package:fuoday/features/teams/presentation/screens/teams_screen.dart';
import 'package:fuoday/features/time_tracker/presentation/screens/time_tracker_screen.dart';
import 'package:fuoday/features/work/presentation/screens/work_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/ats_candidate/presentation/screens/ats_job_information_screen.dart';
import '../../features/ats_support/presentation/screens/my_ticket_view_screen.dart';

/// Enhanced Transition helpers with better animation curves and timing

CustomTransitionPage<T> _buildPageWithTransition<T>({
  required GoRouterState state,
  required Widget child,
  required Widget Function(Animation<double>, Animation<double>, Widget)
  transition,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return transition(animation, secondaryAnimation, child);
    },
    transitionDuration: const Duration(
      milliseconds: 400,
    ), // Slightly faster for better UX
    reverseTransitionDuration: const Duration(milliseconds: 350),
  );
}

/// Smooth Slide from right with better curve
Widget _slideFromRight(
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.fastEaseInToSlowEaseOut, // Smoother curve
  );

  // Also animate the exiting page sliding out to the left
  final exitingAnimation = CurvedAnimation(
    parent: secondaryAnimation,
    curve: Curves.fastOutSlowIn,
  );

  return Stack(
    children: [
      // Exiting page slides left
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.3, 0), // Slight left slide for exiting page
        ).animate(exitingAnimation),
        child: Container(
          color: CupertinoColors.systemBackground,
        ), // Background color
      ),
      // Entering page slides from right
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      ),
    ],
  );
}

/// Smooth Slide from left with better curve
// Widget _slideFromLeft(
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
//   Widget child,
// ) {
//   final curvedAnimation = CurvedAnimation(
//     parent: animation,
//     curve: Curves.fastEaseInToSlowEaseOut,
//   );
//
//   // Also animate the exiting page sliding out to the right
//   final exitingAnimation = CurvedAnimation(
//     parent: secondaryAnimation,
//     curve: Curves.fastOutSlowIn,
//   );
//
//   return Stack(
//     children: [
//       // Exiting page slides right
//       SlideTransition(
//         position: Tween<Offset>(
//           begin: Offset.zero,
//           end: const Offset(0.3, 0), // Slight right slide for exiting page
//         ).animate(exitingAnimation),
//         child: Container(color: CupertinoColors.systemBackground),
//       ),
//       // Entering page slides from left
//       SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(-1.0, 0),
//           end: Offset.zero,
//         ).animate(curvedAnimation),
//         child: child,
//       ),
//     ],
//   );
// }

/// Smooth Fade in with scale effect
Widget _fadeIn(
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOutCubicEmphasized, // Better fade curve
  );

  return FadeTransition(
    opacity: curvedAnimation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    ),
  );
}

/// Scale in with fade
// Widget _scaleIn(
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
//   Widget child,
// ) {
//   final curvedAnimation = CurvedAnimation(
//     parent: animation,
//     curve: Curves.elasticOut, // More natural scale animation
//   );
//
//   return ScaleTransition(
//     scale: Tween<double>(begin: 0.8, end: 1).animate(curvedAnimation),
//     child: FadeTransition(opacity: curvedAnimation, child: child),
//   );
// }

/// Smooth Slide up from bottom
Widget _slideUp(
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.fastEaseInToSlowEaseOut,
  );

  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 0.5), // Start from slightly above bottom
      end: Offset.zero,
    ).animate(curvedAnimation),
    child: FadeTransition(opacity: curvedAnimation, child: child),
  );
}

/// App Router with improved transitions
final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,

  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      name: AppRouteConstants.splash,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: SplashScreen(),
        transition: _fadeIn,
      ),
    ),
    GoRoute(
      path: "/onBoarding",
      name: AppRouteConstants.onBoarding,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: OnBoardingScreen(),
        transition: _fadeIn,
      ),
    ),
    GoRoute(
      path: "/authLogin",
      name: AppRouteConstants.login,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AuthLoginScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/privacyPolicy",
      name: AppRouteConstants.privacyPolicy,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: PrivacyPolicyScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/termsOfService",
      name: AppRouteConstants.termsOfService,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TermsOfServiceScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/authForgetPassword",
      name: AppRouteConstants.forgetPassword,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AuthForgetPasswordScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/authOTP",
      name: AppRouteConstants.otp,
      pageBuilder: (context, state) {
        final email = state.extra as String? ?? '';
        return _buildPageWithTransition(
          state: state,
          child: AuthOtpScreen(email: email),
          transition: _slideFromRight,
        );
      },
    ),
    GoRoute(
      path: "/resetPassword",
      name: AppRouteConstants.resetPassword,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, String>;
        return _buildPageWithTransition(
          state: state,
          child: AuthResetPasswordScreen(
            email: data['email']!,
            otp: data['otp']!,
          ),
          transition: _slideFromRight,
        );
      },
    ),
    GoRoute(
      path: "/homeEmployee",
      name: AppRouteConstants.homeEmployee,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HomeEmployeeScreen(),
        transition: _fadeIn,
      ),
    ),
    GoRoute(
      path: "/homeRecruiter",
      name: AppRouteConstants.homeRecruiter,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HomeRecruiterScreen(),
        transition: _fadeIn,
      ),
    ),
    GoRoute(
      path: "/profile",
      name: AppRouteConstants.profile,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfileScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/profileEducationalBackground",
      name: AppRouteConstants.profileEducationalBackground,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfileEducationalBackgroundScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/profileEmploymentDetails",
      name: AppRouteConstants.profileEmploymentDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfileEmploymentDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/profileOnBoarding",
      name: AppRouteConstants.profileOnBoarding,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfileOnBoardingScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/profilePersonalDetails",
      name: AppRouteConstants.profilePersonalDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfilePersonalDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/profileProfessionalExperience",
      name: AppRouteConstants.profileProfessionalExperience,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ProfileProfessionalExperienceScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/approval",
      name: AppRouteConstants.approval,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ApprovalScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/feeds",
      name: AppRouteConstants.feeds,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: FeedsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/leaveTracker",
      name: AppRouteConstants.leaveTracker,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: LeaveTrackerScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/notification",
      name: AppRouteConstants.notification,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: NotificationScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/work",
      name: AppRouteConstants.work,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: WorkScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/calendar",
      name: AppRouteConstants.calendar,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: CalendarScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/employeeBottomNav",
      name: AppRouteConstants.employeeBottomNav,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: const EmployeeBottomNav(),
        transition: _slideUp,
      ),
    ),
    GoRoute(
      path: "/recruiterBottomNav",
      name: AppRouteConstants.recruiterBottomNav,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: RecruiterBottomNav(),
        transition: _slideUp,
      ),
    ),
    GoRoute(
      path: "/teams",
      name: AppRouteConstants.teams,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TeamsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsCandidate",
      name: AppRouteConstants.atsCandidate,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: CandidateScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsCandidateInformationScreen",
      name: AppRouteConstants.atsCandidateInformationScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: CandidateInformationScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsCandidateApplicationViewScreen",
      name: AppRouteConstants.atsCandidateApplicationViewScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: CandidateApplicationViewScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsTrackerScreen",
      name: AppRouteConstants.atsTrackerScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsTrackerScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/interviewScreen",
      name: AppRouteConstants.interviewScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: InterviewScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/hiringScreen",
      name: AppRouteConstants.hiringScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HiringScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsCalendarScreen",
      name: AppRouteConstants.atsCalendarScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsCalenderScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsIndexScreen",
      name: AppRouteConstants.atsIndexScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsIndexScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsJobPortalScreen",
      name: AppRouteConstants.atsJobPortalScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsJobPortalScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsAdminTabScreen",
      name: AppRouteConstants.atsAdminTabScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsAdminScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsSupportScreen",
      name: AppRouteConstants.atsSupportScreen,
      pageBuilder: (context, state) {
        final tabIndex = state.extra as int?;

        return _buildPageWithTransition(
          state: state,
          child: AtsSupportScreen(initialTabIndex: tabIndex),
          transition: _slideFromRight,
        );
      },
    ),

    GoRoute(
      path: "/atsMyTicketViewScreen",
      name: AppRouteConstants.atsMyTicketViewScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: MyTicketViewScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsNewTicketScreen",
      name: AppRouteConstants.atsNewTicketScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: NewTicketScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsHelpCenterScreen",
      name: AppRouteConstants.atsHelpCenterScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsHelpCenterScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsSettingsScreen",
      name: AppRouteConstants.atsSettingsScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AtsSettingsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/organizations",
      name: AppRouteConstants.organizations,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: OrganizationsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/attendance",
      name: AppRouteConstants.attendance,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AttendanceScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/attendancePunctualArrivalsDetails",
      name: AppRouteConstants.attendancePunctualArrivalsDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AttendancePunctualArrivalDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/attendanceAbsentDetails",
      name: AppRouteConstants.attendanceAbsentDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AttendanceAbsentDaysDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/attendanceLateArrivalDetails",
      name: AppRouteConstants.attendanceLateArrivalDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AttendanceLateArrivalDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/attendanceEarlyArrivalDetails",
      name: AppRouteConstants.attendanceEarlyArrivalDetails,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: AttendanceEarlyArrivalsDetailsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/totalAttendanceView",
      name: AppRouteConstants.totalAttendanceView,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TotalAttendanceViewScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/support",
      name: AppRouteConstants.support,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: SupportScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/timeTracker",
      name: AppRouteConstants.timeTracker,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TimeTrackerScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/paySlip",
      name: AppRouteConstants.paySlip,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: PaySlipScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/performance",
      name: AppRouteConstants.performance,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: PerformanceScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/teamTree",
      name: AppRouteConstants.teamTree,
      pageBuilder: (context, state) {
        final hive = getIt<HiveStorageService>();
        final int webUserId =
            int.tryParse(hive.employeeDetails?['web_user_id'] ?? '0') ?? 0;
        return _buildPageWithTransition(
          state: state,
          child: TeamTreeScreen(webUserId: webUserId),
          transition: _slideFromRight,
        );
      },
    ),
    GoRoute(
      path: "/hr",
      name: AppRouteConstants.hr,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRScreen(),
        transition: _slideFromRight,
      ),
    ),
    //Hr Total Employees Screen
    GoRoute(
      path: "/hrTotalEmployeesScreen",
      name: AppRouteConstants.hrTotalEmployeesScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRTotalEmployeesScreen(),
        transition: _slideFromRight,
      ),
    ),
    //HR TotalLeaveRequestScreen
    GoRoute(
      path: "/hrTotalLeaveRequestScreen",
      name: AppRouteConstants.hrTotalLeaveRequestScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRTotalLeaveRequestScreen(),
        transition: _slideFromRight,
      ),
    ),
    // HR TotalAttendanceScreen
    GoRoute(
      path: "/hrTotalAttendanceScreen",
      name: AppRouteConstants.hrTotalAttendanceScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRTotalAttendanceRepotScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsDraftScreen",
      name: AppRouteConstants.atsDraftScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: DraftScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/atsScheduleInterviewScreen",
      name: AppRouteConstants.atsScheduleInterviewScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ScheduleInterviewScreen(),
        transition: _slideFromRight,
      ),
    ),
    // HR LateArrivalScreen
    GoRoute(
      path: "/hrLateArrivalScreen",
      name: AppRouteConstants.hrLateArrivalScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRLateArrivalScreen(),
        transition: _slideFromRight,
      ),
    ),
    // HR LateArrivalScreen
    GoRoute(
      path: "/hrRegulationScreen",
      name: AppRouteConstants.hrRegulationScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRRegulationAprovalScreen(),
        transition: _slideFromRight,
      ),
    ),
    // HR LateArrivalScreen
    GoRoute(
      path: "/hrPayRollScreen",
      name: AppRouteConstants.hrPayRollScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRTotalPayrollRepotScreen(),
        transition: _slideFromRight,
      ),
    ),
    // HR LateArrivalScreen
    GoRoute(
      path: "/hrPermissionsScreen",
      name: AppRouteConstants.hrPermissionsScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: HRPermissionsScreen(),
        transition: _slideFromRight,
      ),
    ),
    //Team Leader Screens
    GoRoute(
      path: "/teamLeader",
      name: AppRouteConstants.teamLeader,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TeamLeaderScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/tlTotalEmployeesScreen",
      name: AppRouteConstants.tlTotalEmployeesScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TLTotalEmployeesScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/tlTotalAttendanceScreen",
      name: AppRouteConstants.tlTotalAttendanceScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TLTotalAttendanceRepotScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/tlLateArrivalScreen",
      name: AppRouteConstants.tlLateArrivalScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TLLateArrivalScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/tlTotalLeaveRequestScreen",
      name: AppRouteConstants.tlTotalLeaveRequestScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TLTotalLeaveRequestScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/tlRegulationScreen",
      name: AppRouteConstants.tlRegulationScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: TLRegulationAprovalScreen(),
        transition: _slideFromRight,
      ),
    ),

    //Manager  Screens
    GoRoute(
      path: "/manager",
      name: AppRouteConstants.manager,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerTotalEmployeesScreen",
      name: AppRouteConstants.managerTotalEmployeesScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerTotalEmployeesScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerTotalAttendanceScreen",
      name: AppRouteConstants.managerTotalAttendanceScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerTotalAttendanceRepotScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerLateArrivalScreen",
      name: AppRouteConstants.managerLateArrivalScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerLateArrivalScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerTotalLeaveRequestScreen",
      name: AppRouteConstants.managerTotalLeaveRequestScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerTotalLeaveRequestScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerRegulationScreen",
      name: AppRouteConstants.managerRegulationScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerRegulationAprovalScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/managerFeedScreen",
      name: AppRouteConstants.managerFeedScreen,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagerFeedsScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/management",
      name: AppRouteConstants.management,
      pageBuilder: (context, state) => _buildPageWithTransition(
        state: state,
        child: ManagementScreen(),
        transition: _slideFromRight,
      ),
    ),
    GoRoute(
      path: "/pdfPreview",
      name: AppRouteConstants.pdfPreview,
      pageBuilder: (context, state) {
        final data = state.extra as FilePreviewData;
        return _buildPageWithTransition(
          state: state,
          child: PdfPreviewScreen(
            filePath: data.filePath,
            fileName: data.fileName,
          ),
          transition: _slideFromRight,
        );
      },
    ),
    GoRoute(
      path: "/imagePreview",
      name: AppRouteConstants.imagePreview,
      pageBuilder: (context, state) {
        final data = state.extra as FilePreviewData;
        return _buildPageWithTransition(
          state: state,
          child: ImagePreviewScreen(
            filePath: data.filePath,
            fileName: data.fileName,
          ),
          transition: _slideFromRight,
        );
      },
    ),
  ],
);
