import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuoday/common_main.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: AppAssetsConstants.env);

  setUpServiceLocator();

  // Environment Dev
  AppEnvironment.setUpEnv(Environment.development);

  // Common Main
  commonMain();
}
