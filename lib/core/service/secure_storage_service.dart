import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fuoday/core/constants/storage/app_flutter_secure_storage_constants.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Save token
  Future<void> saveToken({required String token}) async {
    await _storage.write(
      key: AppFlutterSecureStorageConstants.authToken,
      value: token,
    );
  }

  /// Read token
  Future<String?> getToken() async {
    return await _storage.read(key: AppFlutterSecureStorageConstants.authToken);
  }

  /// Delete token
  Future<void> deleteToken() async {
    await _storage.delete(key: AppFlutterSecureStorageConstants.authToken);
  }

  /// Check if token exists
  Future<bool> hasToken() async {
    return await _storage.containsKey(
      key: AppFlutterSecureStorageConstants.authToken,
    );
  }
}
