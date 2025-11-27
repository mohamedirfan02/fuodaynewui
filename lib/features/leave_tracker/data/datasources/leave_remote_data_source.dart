import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/features/leave_tracker/data/models/leave_report_models.dart';
import 'package:hive/hive.dart';
import '../models/leave_summary_model.dart';

class LeaveRemoteDataSource {
  final Dio dio;

  LeaveRemoteDataSource(this.dio);

  Future<List<LeaveSummaryModel>> fetchLeaveSummary(String webUserId) async {
    final response = await dio.get('/hrms/leave/getleave/$webUserId');
    final data = response.data['data']['leave_summary'] as List;

    return data.map((e) => LeaveSummaryModel.fromJson(e)).toList();
  }

  // Reports
  Future<List<LeaveReportModel>> fetchLeaveReport(String webUserId) async {
    final response = await dio.get('/hrms/leave/getleave/$webUserId');
    final data = response.data['data']['leave_report'] as List;
    return data.map((e) => LeaveReportModel.fromJson(e)).toList();
  }

  //leave request
  Future<void> sendLeaveRequest({
    required String type,
    required String fromDate,
    required String toDate,
    required String reason,
    required String permissionTiming,
  }) async {

    final box = Hive.box(AppHiveStorageConstants.employeeDetailsBoxKey);
    final employeeMap = box.get(AppHiveStorageConstants.employeeDetailsKey, defaultValue: {});

    final webUserId = employeeMap['web_user_id'] ?? 0;

    if (webUserId == 0) {
      print("❌ web_user_id is missing in Hive. Please login again.");
      throw Exception("web_user_id missing.");
    }

    // Build body conditionally
    final body = <String, dynamic>{
      "web_user_id": webUserId,
      "type": type,
      "from": fromDate,
      "to": toDate,
      "reason": reason,
    };

    // Only add permission_timing if it's a permission leave type and timing is provided
    if (type.toLowerCase() == 'permission' && permissionTiming != null && permissionTiming.isNotEmpty) {
      body["permission_timing"] = permissionTiming;
    }

    print("📤 Sending Leave Request...");
    print("➡️ Payload: $body");

    try {
      final response = await dio.post(
        AppApiEndpointConstants.requestLeave,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status != null && (status < 500),
        ),
      );

      print("📥 Response Status Code: ${response.statusCode}");
      print("📥 Response Data: ${response.data}");

      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value('location');
        print("🔁 Redirecting to: $redirectUrl");
        if (redirectUrl != null) {
          final redirectResponse = await dio.get(redirectUrl);
          print("🔁 Redirect Response: ${redirectResponse.statusCode}");
          return;
        }
      }

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print("✅ Leave request submitted successfully.");
        return;
      }

      throw Exception("Unexpected status code: ${response.statusCode}");
    } catch (e) {
      print("❌ Leave request failed: $e");
      throw Exception("Leave request failed: $e");
    }
  }





}
