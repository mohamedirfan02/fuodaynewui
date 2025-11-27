import 'package:fuoday/config/flavors/flavors_config.dart';

class AppApiEndpointConstants {
  // Base Url
  static String get baseUrl => AppEnvironment.baseUrl;

  // Login Endpoint
  static String get login => '$baseUrl/web-users/login';

  // Logout Endpoint
  static String get logout => '$baseUrl/web-users/logout';

  // CheckIn Endpoint
  static String get checkIn => '$baseUrl/hrms/attendance/addattendance';

  // CheckOut Endpoint
  static String get checkOut => '$baseUrl/hrms/attendance/updateattendance';

  // Calendar Endpoint
  static String get getSchedules => '$baseUrl/hrms/timetracker/getschedules';

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
  static String allEmployeeList(String webUserId) =>
      '$baseUrl/web-users/getemployeesbyadmin/$webUserId';

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
}
