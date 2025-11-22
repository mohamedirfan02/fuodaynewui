import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late Box _themeBox;

  ThemeProvider() {
    _initHive();
  }

  ThemeMode get themeMode => _themeMode;

  // Initialize Hive and load saved theme
  Future<void> _initHive() async {
    try {
      _themeBox = Hive.box(AppHiveStorageConstants.themeBoxKey);
      _loadThemeFromHive();
      AppLoggerHelper.logInfo("✅ Theme provider initialized successfully.");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to initialize theme provider: $e");
    }
  }

  // Load saved theme preference from Hive
  void _loadThemeFromHive() {
    try {
      final savedTheme = _themeBox.get(
        AppHiveStorageConstants.themeModeKey,
        defaultValue: 'system',
      );

      switch (savedTheme) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'system':
        default:
          _themeMode = ThemeMode.system;
          break;
      }

      AppLoggerHelper.logInfo("📦 Loaded theme mode: $savedTheme");
      notifyListeners();
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to load theme: $e");
    }
  }

  // Save theme preference to Hive
  Future<void> _saveThemeToHive(String mode) async {
    try {
      await _themeBox.put(AppHiveStorageConstants.themeModeKey, mode);
      AppLoggerHelper.logInfo("💾 Theme mode saved: $mode");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to save theme: $e");
    }
  }

  // Set theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    String modeString = mode.toString().split('.').last;
    _saveThemeToHive(modeString);
    notifyListeners();
  }

  // Convenience methods
  void setLightMode() {
    setThemeMode(ThemeMode.light);
    AppLoggerHelper.logInfo("☀️ Light mode activated");
  }

  void setDarkMode() {
    setThemeMode(ThemeMode.dark);
    AppLoggerHelper.logInfo("🌙 Dark mode activated");
  }

  void setSystemMode() {
    setThemeMode(ThemeMode.system);
    AppLoggerHelper.logInfo("🔄 System theme mode activated");
  }

  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  @override
  void dispose() {
    // Don't close the box here since it's managed by HiveStorageService
    super.dispose();
  }
}
