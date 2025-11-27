import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/profile/domain/repository/employee_profile_repository.dart';

Future<void> fetchAndUseEmployeeProfile(EmployeeProfileRepository repo) async {
  final hive = HiveStorageService();
  final employeeData = hive.employeeDetails;

  if (employeeData == null || !employeeData.containsKey('web_user_id')) {
    print("⛔ web_user_id not found in employeeDetails.");
    return;
  }

  final String webUserId = employeeData['web_user_id'];

  try {
    final profile = await repo.getProfile(webUserId);
   // print("✅ Fetched profile: ${profile.name}"); // or whatever your fields are
  } catch (e) {
    print("❌ Failed to fetch profile: $e");
  }
}
