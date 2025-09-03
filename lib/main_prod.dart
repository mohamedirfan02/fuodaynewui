import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuoday/common_main.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/constants/assets/app_assets_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: AppAssetsConstants.env);

  // Environment Dev
  AppEnvironment.setUpEnv(Environment.production);

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final app = Firebase.app();
  print("🔥 Firebase initialized: ${app.name}");

  //flutter build apk --flavor prod -t lib/main_prod.dart --release

  await Hive.initFlutter(); // Required if you're using hive_flutter

  // Open the box
  await Hive.openBox('employeeDetails');

  // Common Main
  commonMain();
}
