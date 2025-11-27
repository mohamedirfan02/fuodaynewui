import 'package:fuoday/config/flavors/flavors_config.dart';

class AppApiEndpointConstants {
  // Base Url
  static String get baseUrl => AppEnvironment.baseUrl;

  // Login Endpoint
  static String get login => '$baseUrl/web-users/login';

  // Logout Endpoint
  static String get logout => '$baseUrl/web-users/logout';

  //Forgot password send otp Enpoint
  static String get forgotPassword =>
      '$baseUrl/web-users/forgot-password/send-otp'; //reset-password

  //Forgot password Verify otp Enpoint
  static String get forgotPasswordOTPverify =>
      '$baseUrl/web-users/forgot-password/verify-otp';

  //resetPassword Enpoint
  static String get resetPassword =>
      '$baseUrl/web-users/forgot-password/reset-password';

  // CheckIn Endpoint
  static String get checkIn => '$baseUrl/hrms/attendance/addattendance';

  // CheckOut Endpoint
  static String get checkOut => '$baseUrl/hrms/attendance/updateattendance';

  // Calendar Endpoint
  static String getSchedules(String webUserId) =>
      '$baseUrl/hrms/timetracker/getSchedules/$webUserId';

  // Request Leave Endpoint
  static String get requestLeave => '$baseUrl/hrms/leave/addleave';

  //update professional experience
  static String get updateExperience =>
      '$baseUrl/hrms/profile/updateexperience';

  //sending Onboard details Endpoint
  static String get updateOnboarding =>
      '$baseUrl/hrms/profile/updateonboarding';

  // Get Profile Data - requires webUserId
  static String profileData(String webUserId) =>
      '$baseUrl/hrms/profile/getprofile/$webUserId';

  // Leave Tracker Endpoint - requires webUserId
  static String leaveTracker(String webUserId) =>
      '$baseUrl/hrms/leave/getleave/$webUserId';

  // Get All Profile Details - requires webUserId
  static String getAllProfileDetails(String webUserId) =>
      '$baseUrl/hrms/profile/getprofile/$webUserId';

  // Put employee profile - requires web user id
  static String updateEmployeeProfile(String webUserId) =>
      '$baseUrl/hrms/profile/updateemployeeprofile';

  // All Events
  static String announcements(String webUserId) =>
      '$baseUrl/hrms/home/getannouncements/$webUserId/announcement';

  static String celebrations(String webUserId) =>
      '$baseUrl/hrms/home/getannouncements/$webUserId/Celebration';

  static String organizationalPrograms(String webUserId) =>
      '$baseUrl/hrms/home/getannouncements/$webUserId/operation';

  //get Home feeds project details data - requires webUserId
  static String feedData(String webUserId) =>
      '$baseUrl/hrms/home/getfeeds/$webUserId';

  //get all employee name and id list for assign task
  static String allEmployeeList(String id) =>
      '$baseUrl/admin-users/getemployeesname/$id';

  //assign task to employee endpoint
  static String get assignTask => '$baseUrl/hrms/home/addtask';

  // get team report
  static String teamReport(String webUserId) =>
      '$baseUrl/hrms/home/getreportees/$webUserId';

  // get projects
  static String projects(String webUserId) =>
      '$baseUrl/hrms/home/getprojects/$webUserId';

  // get team list
  static String teamList(String webUserId) =>
      '$baseUrl/hrms/home/getteam/$webUserId';

  // get time and project tracker
  static String getTimeAndProjectTracker(String webUserId) =>
      '$baseUrl/hrms/timetracker/gettracker/$webUserId';

  // get data for about screen
  static String getAbout(String webUserId) =>
      '$baseUrl/hrms/home/about_client/$webUserId';

  //Organization Services and ind
  static String getServInd(String webUserId) =>
      '$baseUrl/hrms/home/industry_service/$webUserId';

  // Organization Dept and Team list
  static String getDeptTeamList(String webUserId) =>
      '$baseUrl/hrms/home/getdepartments/$webUserId';

  // update profile data
  static String get updateProfile =>
      '$baseUrl/hrms/profile/updateemployeeprofile';

  // Get Total Attendance Details
  static String getTotalAttendanceDetails(int webUserId) =>
      '$baseUrl/hrms/attendance/getattendances/$webUserId';

  // Get Late Attendance Late Arrivals Details
  static String getLateAttendanceLateArrivalsDetails(int webUserId) =>
      '$baseUrl/hrms/attendance/late-arrivals/$webUserId';

  // Get Punctual Arrivals Details
  static String getPunctualArrivalsDetails(int webUserId) =>
      '$baseUrl/hrms/attendance/punctual-arrivals/$webUserId';

  // Get Early Arrivals Arrivals Details
  static String getEarlyArrivalsDetails(int webUserId) =>
      '$baseUrl/hrms/attendance/early-arrivals/$webUserId';

  // Get Absent Days Details
  static String getAbsentDaysDetails(int webUserId) =>
      '$baseUrl/hrms/attendance/absent-days/$webUserId';

  //get Assigned, UnAssigned, InProgress, Completed Ticket
  static String getTicketsDetails(int webUserId) =>
      '$baseUrl/hrms/support/gettickets/$webUserId';

  //create ticket endpoint
  static String get createTicket => '$baseUrl/hrms/support/addticket';

  // get performance summary
  static String getPerformanceSummary(int webUserId) =>
      '$baseUrl/hrms/performance/getperformance/$webUserId';

  // get employee audit
  static String getEmployeeAudit(int webUserId) =>
      '$baseUrl/hrms/performance/getemployeeaudit/$webUserId';

  // post audit form
  static String postAuditForm = '$baseUrl/hrms/performance/addaudit';

  //get payroll details
  static String getPayroll(int webUserId) =>
      '$baseUrl/hrms/payroll/getpayroll/$webUserId';

  //get PayRoll OverView Details
  static String getPayrollOverView(int webUserId) =>
      '$baseUrl/hrms/payroll/getoverview/$webUserId';

  // download payslip
  static String downloadPayslip(int webUserId) =>
      '$baseUrl/hrms/payroll/downloadpayslip/$webUserId';

  //HrOverview screen
  static String getHrOverview(int webUserId) =>
      '$baseUrl/hrms/hr/gethr/$webUserId';

  //Create and update events
  static String addEvents = '$baseUrl/admin-users/save/event';

  //Get getEmployeesByManagers
  static String getEmployeesByManagers(int webUserId) =>
      '$baseUrl/web-users/getemployeesbymanagers/$webUserId';

  //Leave Regulation
  static String leaveRegulation = '$baseUrl/hrms/leave/regulate';

  static String updateTasks = '$baseUrl/hrms/performance/updatetasks';

  // send badge data
  static String addBadges = '$baseUrl/hrms/home/recognitions';

  //get audit reporting team
  static String getAuditReportingTeam(int webUserId) =>
      '$baseUrl/hrms/performance/getauditreportingteam/$webUserId';

  //get checkIn checkOut status and time
  static String getCheckInCheckOutStatusAndTime(int webUserId) =>
      '$baseUrl/hrms/home/getactivities/$webUserId';

  // get each person audit from
  static String getEachPersonAuditForm(int id) =>
      '$baseUrl/hrms/performance/getauditreport/$id';

  // get teamTreeByAccordingToManagerName
  static String getTeamTree(int webUserId) =>
      '$baseUrl/web-users/getemployeesbymanagers/$webUserId';

  // get All Badges
  static String getBadges(int webUserId) =>
      '$baseUrl/hrms/home/recognitions/$webUserId';
  // get All Badges
  static String getEmpDepartment(int webUserId) =>
      '$baseUrl/web-users/getemployeesbyadmin/$webUserId';

  //Get role_based_users in Hr,TL,Manager Screens
  static String getAllWebUsers(int webUserId) =>
      '$baseUrl/hrms/hr/getallwebusers/$webUserId';

  //Get role_based_users in Hr,TL,Manager Screens
  static String getAllAttendance(int webUserId) =>
      '$baseUrl/hrms/hr/all-attendance/$webUserId';

  //Get role_based_users in Hr,TL,Manager Screens
  static String getAllLateArrivalsReport() =>
      '$baseUrl/hrms/attendance/late-arrivals-all';

  // Get all leaves by status
  static String getAllLeavesByStatus(String status) =>
      '$baseUrl/hrms/hr/getallleavesbystatus/$status';

  //Get Regulation API
  static String getAllRegulation(int webUserId) =>
      '$baseUrl/hrms/hr/regulations/$webUserId';

  //Update leave request
  static String updateLeave = '$baseUrl/hrms/leave/updateleave';
  //Update Regulation
  static String updatRegulation = '$baseUrl/hrms/hr/update-regulation-status';

  //  Get all Payroll in HR Tab
  static String getTotalPayrollSummary() => '$baseUrl/hrms/hr/payroll-summary';



  //====================ATS PAGES=====================================

  // Get ATS Candidates
  static String getCandidates(String webUserId) =>
      '$baseUrl/ats/candidates/getcandidates?web_user_id=$webUserId';

  // Candidate Save (Add / Edit / Delete)
  static String get candidateActions => "$baseUrl/ats/candidates/save";
}
