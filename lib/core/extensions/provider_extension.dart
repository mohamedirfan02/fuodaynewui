import 'package:flutter/material.dart';
import 'package:fuoday/commons/providers/checkbox_provider.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/core/providers/app_file_downloader_provider.dart';
import 'package:fuoday/core/providers/app_file_picker_provider.dart';
import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/date_time_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_absent_days_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_attendance_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_early_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_late_arrivals_details_provider.dart';
import 'package:fuoday/features/attendance/presentation/providers/total_punctual_arrivals_details_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_login_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_logout_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/sliding_segmented_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/bottom_nav_provider.dart';
import 'package:fuoday/features/bottom_nav/providers/recruiter_bottom_nav_provider.dart';
import 'package:fuoday/features/calendar/presentation/providers/shift_schedule_provider.dart';
import 'package:fuoday/features/home/presentation/provider/all_events_provider.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/home/presentation/provider/checkin_status_provider.dart';
import 'package:fuoday/features/manager/presentation/provider/update_leave_status_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_form_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/employee_audit_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/performance_summary_provider.dart';
import 'package:fuoday/features/performance/presentation/providers/rating_provider.dart';
import 'package:fuoday/features/profile/presentation/providers/profile_edit_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_leave_requests_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/all_role_total_attendance_report_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/late_arrivals_provider.dart';
import 'package:fuoday/features/team_leader/presentation/provider/role_based_users_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_members_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_project_provider.dart';
import 'package:fuoday/features/teams/presentation/providers/team_reportees_provider.dart';
import 'package:provider/provider.dart';

extension ProviderExtension on BuildContext {
  // Check box provider
  CheckboxProvider get checkBoxProviderRead => read<CheckboxProvider>();

  CheckboxProvider get checkBoxProviderWatch => watch<CheckboxProvider>();

  // Drop down provider
  DropdownProvider get dropDownProviderRead => read<DropdownProvider>();

  DropdownProvider get dropDownProviderWatch => watch<DropdownProvider>();

  // Bottom Nav Provider
  BottomNavProvider get bottomNavProviderRead => read<BottomNavProvider>();

  BottomNavProvider get bottomNavProviderWatch => watch<BottomNavProvider>();

  // Recruiter nav
  RecruiterBottomNavProvider get recruiterBottomNavProviderRead =>
      read<RecruiterBottomNavProvider>();
  RecruiterBottomNavProvider get recruiterBottomNavProviderWatch =>
      watch<RecruiterBottomNavProvider>();

  // Sliding Segmented Provider
  SlidingSegmentedProvider get slidingSegmentProviderRead =>
      read<SlidingSegmentedProvider>();

  SlidingSegmentedProvider get slidingSegmentProviderWatch =>
      watch<SlidingSegmentedProvider>();

  // Profile Edit Provider
  ProfileEditProvider get profileEditProviderRead =>
      read<ProfileEditProvider>();

  ProfileEditProvider get profileEditProviderWatch =>
      watch<ProfileEditProvider>();

  // App File Picker Provider
  AppFilePickerProvider get filePickerProviderWatch =>
      watch<AppFilePickerProvider>();

  AppFilePickerProvider get filePickerProviderRead =>
      read<AppFilePickerProvider>();

  // Check In Provider
  CheckInProvider get checkInProviderWatch => watch<CheckInProvider>();

  CheckInProvider get checkInProviderRead => read<CheckInProvider>();

  // App File Downloader Provider
  AppFileDownloaderProvider get appFileDownloaderProviderWatch =>
      watch<AppFileDownloaderProvider>();

  AppFileDownloaderProvider get appFileDownloaderProviderRead =>
      read<AppFileDownloaderProvider>();

  // Employee Auth Login Provider
  EmployeeAuthLoginProvider get employeeAuthLoginProviderWatch =>
      watch<EmployeeAuthLoginProvider>();

  EmployeeAuthLoginProvider get employeeAuthLoginProviderRead =>
      read<EmployeeAuthLoginProvider>();

  // Employee Auth Logout Provider
  EmployeeAuthLogoutProvider get employeeAuthLogOutProviderWatch =>
      watch<EmployeeAuthLogoutProvider>();

  EmployeeAuthLogoutProvider get employeeAuthLogoutProviderRead =>
      read<EmployeeAuthLogoutProvider>();

  // All Events Provider
  AllEventsProvider get allEventsProviderWatch => watch<AllEventsProvider>();

  AllEventsProvider get allEventsProviderRead => read<AllEventsProvider>();

  // Shift Schedule Provider
  ShiftScheduleProvider get shiftScheduleProviderWatch =>
      watch<ShiftScheduleProvider>();

  ShiftScheduleProvider get shiftScheduleProviderRead =>
      read<ShiftScheduleProvider>();

  // Team Member Provider
  TeamMembersProvider get teamMemberProviderWatch =>
      watch<TeamMembersProvider>();

  TeamMembersProvider get teamMemberProviderRead => read<TeamMembersProvider>();

  // Team Project Provider
  TeamProjectProvider get teamProjectProviderWatch =>
      watch<TeamProjectProvider>();

  TeamProjectProvider get teamProjectProviderRead =>
      read<TeamProjectProvider>();

  // Team Reportee Provider
  TeamReporteesProvider get teamReporteesProviderWatch =>
      watch<TeamReporteesProvider>();

  TeamReporteesProvider get teamReporteesProviderRead =>
      read<TeamReporteesProvider>();

  // Total Attendance Details Provider
  TotalAttendanceDetailsProvider get totalAttendanceDetailsProviderWatch =>
      watch<TotalAttendanceDetailsProvider>();

  TotalAttendanceDetailsProvider get totalAttendanceDetailsProviderRead =>
      read<TotalAttendanceDetailsProvider>();

  // Total Late Arrivals Details Provider
  TotalLateArrivalsDetailsProvider get totalLateArrivalsDetailsProviderWatch =>
      watch<TotalLateArrivalsDetailsProvider>();

  TotalLateArrivalsDetailsProvider get totalLateArrivalsDetailsProviderRead =>
      read<TotalLateArrivalsDetailsProvider>();

  // Total Early Arrivals Details Provider
  TotalEarlyArrivalsDetailsProvider
  get totalEarlyArrivalsDetailsProviderWatch =>
      read<TotalEarlyArrivalsDetailsProvider>();

  TotalEarlyArrivalsDetailsProvider get totalEarlyArrivalsDetailsProviderRead =>
      read<TotalEarlyArrivalsDetailsProvider>();

  // Total Absent Days Details Provider
  TotalAbsentDaysDetailsProvider get totalAbsentDaysDetailsProviderWatch =>
      watch<TotalAbsentDaysDetailsProvider>();

  TotalAbsentDaysDetailsProvider get totalAbsentDaysDetailsProviderRead =>
      read<TotalAbsentDaysDetailsProvider>();

  // Total Punctual Arrival Details Provider
  TotalPunctualArrivalDetailsProvider
  get totalPunctualArrivalDetailsProviderWatch =>
      watch<TotalPunctualArrivalDetailsProvider>();

  TotalPunctualArrivalDetailsProvider
  get totalPunctualArrivalDetailsProviderRead =>
      read<TotalPunctualArrivalDetailsProvider>();

  // Performance Summary Provider
  PerformanceSummaryProvider get performanceSummaryProviderWatch =>
      watch<PerformanceSummaryProvider>();

  PerformanceSummaryProvider get performanceSummaryProviderRead =>
      read<PerformanceSummaryProvider>();

  // Employee Audit Provider
  EmployeeAuditProvider get employeeAuditProviderWatch =>
      watch<EmployeeAuditProvider>();

  EmployeeAuditProvider get employeeAuditProviderRead =>
      read<EmployeeAuditProvider>();

  EmployeeAuditFormProvider get employeeAuditFormProviderRead =>
      read<EmployeeAuditFormProvider>();

  // Employee Audit Form Provider
  EmployeeAuditFormProvider get employeeAuditFormProviderWatch =>
      watch<EmployeeAuditFormProvider>();

  // Rating Provider
  RatingProvider get ratingProviderRead => read<RatingProvider>();

  RatingProvider get ratingProviderWatch => watch<RatingProvider>();

  // App Internet Checker Provider
  AppInternetCheckerProvider get appInternetCheckerProviderRead =>
      read<AppInternetCheckerProvider>();

  AppInternetCheckerProvider get appInternetCheckerProviderWatch =>
      watch<AppInternetCheckerProvider>();

  CheckinStatusProvider get checkinStatusProviderWatch =>
      watch<CheckinStatusProvider>();

  CheckinStatusProvider get checkinStatusProviderRead =>
      read<CheckinStatusProvider>();

  //Date Time Showing Provider
  DateTimeProvider get dateTimeProviderWatch => watch<DateTimeProvider>();

  //RoleBasedUsersProvider
  RoleBasedUsersProvider get roleBasedUsersProviderRead =>
      read<RoleBasedUsersProvider>();
  RoleBasedUsersProvider get roleBasedUsersProviderWatch =>
      watch<RoleBasedUsersProvider>();

  //RoleBasedUsersProvider
  AttendanceReportProvider get roleWiseAttendanceReportProviderRead =>
      read<AttendanceReportProvider>();
  AttendanceReportProvider get roleWiseAttendanceReportProviderWatch =>
      watch<AttendanceReportProvider>();


  //AllRoleLateArrivalsReportProvider
  LateArrivalsProvider get allRoleLateArrivalsReportProviderRead =>
      read<LateArrivalsProvider>();
  LateArrivalsProvider get allRoleLateArrivalsReportProviderWatch =>
      watch<LateArrivalsProvider>();

  //AllRoleLateArrivalsReportProvider
  AllLeaveRequestsProvider get allLeaveRequestProviderRead =>
      read<AllLeaveRequestsProvider>();
  AllLeaveRequestsProvider get allLeaveRequestProviderWatch =>
      watch<AllLeaveRequestsProvider>();

  //AllRoleLateArrivalsReportProvider
  UpdateLeaveStatusProvider get leaveUpdateProviderRead =>
      read<UpdateLeaveStatusProvider>();
  UpdateLeaveStatusProvider get leaveUpdateProviderWatch =>
      watch<UpdateLeaveStatusProvider>();
}
