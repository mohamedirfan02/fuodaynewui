import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class HiveStorageService {
  static final HiveStorageService _instance = HiveStorageService._internal();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  factory HiveStorageService() => _instance;

  HiveStorageService._internal();

  late Box _authBox;
  late Box _onBoardingBox;
  late Box _employeeDetailsBox;
  late Box _themeBox;

  Box get themeBox => _themeBox;

  Future<void> clearAll() async {
    await secureStorage.deleteAll(); // Clears encrypted values
    await Hive.box(AppHiveStorageConstants.authBoxKey).clear();
    await Hive.box(AppHiveStorageConstants.employeeDetailsBoxKey).clear();
    await Hive.box(AppHiveStorageConstants.onBoardingBoxKey).clear();
    await Hive.box(AppHiveStorageConstants.themeBoxKey).clear();
  }

  /// Initialize Hive boxes
  Future<void> init() async {
    try {
      _authBox = await Hive.openBox(AppHiveStorageConstants.authBoxKey);
      _onBoardingBox = await Hive.openBox(
        AppHiveStorageConstants.onBoardingBoxKey,
      );
      _employeeDetailsBox = await Hive.openBox(
        AppHiveStorageConstants.employeeDetailsBoxKey,
      );
      _themeBox = Hive.box(AppHiveStorageConstants.themeBoxKey);
      _draftBox = await Hive.openBox(AppHiveStorageConstants.draftBoxKey);

      AppLoggerHelper.logInfo("✅ Hive boxes initialized successfully.");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to initialize Hive boxes: $e");
    }
  }

  // Key for storing role
  static const _keyUserRole = "userRole";

  /// 🔥 Save user role (employee/recruiter)
  Future<void> setUserRole(String role) async {
    await _authBox.put(_keyUserRole, role);
    AppLoggerHelper.logInfo("💾 User role saved: $role");
  }

  /// 🔥 Get user role
  String get userRole {
    final role = _authBox.get(_keyUserRole, defaultValue: "employee");
    AppLoggerHelper.logInfo("📦 Fetched user role: $role");
    return role;
  }

  /// 🔥 Clear role on logout
  Future<void> clearUserRole() async {
    await _authBox.delete(_keyUserRole);
    AppLoggerHelper.logInfo("🗑️ User role cleared");
  }

  /// Set Auth login status
  Future<void> setIsAuthLogged(bool value) async {
    await _authBox.put(AppHiveStorageConstants.isAuthLoggedInStatus, value);
    AppLoggerHelper.logInfo("Set isAuthLoggedInStatus to: $value");
  }

  /// Get Auth login status
  bool get isAuthLoggedStatus {
    final value = _authBox.get(
      AppHiveStorageConstants.isAuthLoggedInStatus,
      defaultValue: false,
    );
    AppLoggerHelper.logInfo("Fetched isAuthLoggedInStatus: $value");
    return value;
  }

  /// Set OnBoarding status
  Future<void> setOnBoardingIn(bool value) async {
    await _onBoardingBox.put(AppHiveStorageConstants.onBoardingInStatus, value);
    AppLoggerHelper.logInfo("Set onBoardingInStatus to: $value");
  }

  /// Get OnBoarding status
  bool get isOnBoardingInStatus {
    final value = _onBoardingBox.get(
      AppHiveStorageConstants.onBoardingInStatus,
      defaultValue: false,
    );
    AppLoggerHelper.logInfo("Fetched onBoardingInStatus: $value");
    return value;
  }

  /// ✅ Set Employee Details (instance method)
  Future<void> setEmployeeDetails({
    required String role,
    required String empId,
    required String email,
    required String designation,
    required String profilePhoto,
    required String userName,
    required String webUserId,
    String? id, // Added id parameter
    String? logo, // Added logo parameter
    String? checkin,
    required String access, // Added checkin parameter
  }) async {
    final employeeData = {
      "role": role,
      "empId": empId,
      "email": email,
      "designation": designation,
      "profilePhoto": profilePhoto,
      "name": userName,
      "web_user_id": webUserId,
      "id": id, // Store id
      "logo": logo, // Store logo
      "checkin": checkin, // Store checkin
      'access': access, //Store acsess
    };

    await _employeeDetailsBox.put(
      AppHiveStorageConstants.employeeDetailsKey,
      employeeData,
    );
    AppLoggerHelper.logInfo("✅ Employee details saved: $employeeData");
  }

  /// ✅ Static method for compatibility (delegates to instance)
  static Future<void> setEmployeeDetailsStatic({
    required String role,
    required String empId,
    required String email,
    required String designation,
    required String profilePhoto,
    required String userName,
    required String webUserId,
    required String logo,
    required String checkin,
    required String access,
    String? id, // Added id parameter
  }) async {
    final instance = HiveStorageService();
    await instance.setEmployeeDetails(
      role: role,
      empId: empId,
      email: email,
      designation: designation,
      profilePhoto: profilePhoto,
      userName: userName,
      webUserId: webUserId,
      id: id, // Pass id
      logo: logo, // Pass logo
      checkin: checkin,
      access: access,
    );
  }

  /// ✅ Get Employee Details using correct internal key
  Map<String, dynamic>? get employeeDetails {
    try {
      final data = _employeeDetailsBox.get(
        AppHiveStorageConstants.employeeDetailsKey,
      );

      if (data != null) {
        // Handle both Map<String, dynamic> and Map<dynamic, dynamic>
        final Map<String, dynamic> employeeData = Map<String, dynamic>.from(
          data,
        );
        AppLoggerHelper.logInfo("💡 Fetched employee details: $employeeData");
        return employeeData;
      }

      AppLoggerHelper.logError("⛔ No employee details found in box.");
      return null;
    } catch (e) {
      AppLoggerHelper.logError("❌ Error fetching employee details: $e");
      return null;
    }
  }

  /// ✅ Method to check if employee details exist
  bool get hasEmployeeDetails {
    return _employeeDetailsBox.containsKey(
      AppHiveStorageConstants.employeeDetailsKey,
    );
  }

  /// ✅ Method to clear employee details (useful for logout)
  Future<void> clearEmployeeDetails() async {
    await _employeeDetailsBox.delete(
      AppHiveStorageConstants.employeeDetailsKey,
    );
    AppLoggerHelper.logInfo("🗑️ Employee details cleared");
  }

  /// Save or update check-in state inside existing employee details
  Future<void> saveCheckInStatus(bool isCheckedIn, String? checkInTime) async {
    try {
      final current = employeeDetails ?? {};

      current['isCheckedIn'] = isCheckedIn;
      current['checkInTime'] = checkInTime;

      await _employeeDetailsBox.put(
        AppHiveStorageConstants.employeeDetailsKey,
        current,
      );

      AppLoggerHelper.logInfo(
        "💾 Updated check-in status: isCheckedIn=$isCheckedIn, checkInTime=$checkInTime",
      );
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to save check-in status: $e");
    }
  }

  // Open or get an already opened box
  Future<Box> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    return await Hive.openBox(boxName);
  }

  /// ✅ Common PUT method
  Future<void> put(String boxName, String key, dynamic value) async {
    try {
      final box = await _openBox(boxName);
      await box.put(key, value);
      AppLoggerHelper.logInfo("💾 Saved [$key] to box [$boxName]");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to put [$key] in [$boxName]: $e");
    }
  }

  /// ✅ Common GET method
  Future<T?> get<T>(String boxName, String key, {T? defaultValue}) async {
    try {
      final box = await _openBox(boxName);
      final value = box.get(key, defaultValue: defaultValue);
      AppLoggerHelper.logInfo("📦 Fetched [$key] from box [$boxName]: $value");
      return value as T?;
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to get [$key] from [$boxName]: $e");
      return defaultValue;
    }
  }

  /// ✅ Common DELETE method
  Future<void> delete(String boxName, String key) async {
    try {
      final box = await _openBox(boxName);
      await box.delete(key);
      AppLoggerHelper.logInfo("🗑️ Deleted [$key] from box [$boxName]");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to delete [$key] from [$boxName]: $e");
    }
  }

  /// ✅ Common CLEAR method (clear entire box)
  Future<void> clearBox(String boxName) async {
    try {
      final box = await _openBox(boxName);
      await box.clear();
      AppLoggerHelper.logInfo("🧹 Cleared box [$boxName]");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to clear [$boxName]: $e");
    }
  }

  /// ✅ Common GET ALL method
  Future<Map<dynamic, dynamic>> getAll(String boxName) async {
    try {
      final box = await _openBox(boxName);
      final all = Map<dynamic, dynamic>.from(box.toMap());
      AppLoggerHelper.logInfo("📋 All items from box [$boxName]: $all");
      return all;
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to get all from [$boxName]: $e");
      return {};
    }
  }

  static const String _draftBoxKey = "draft_list";

  late Box _draftBox;

  Future<void> saveDraftList(List<Map<String, dynamic>> list) async {
    await _draftBox.put(_draftBoxKey, list);
  }

  Future<List<Map<String, dynamic>>?> getDraftList() async {
    final data = _draftBox.get(_draftBoxKey);
    if (data == null) return null;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> clearDraftList() async {
    await _draftBox.delete(_draftBoxKey);
  }
}
