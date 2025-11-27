import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { development, production }

abstract class AppEnvironment {
  static late String baseUrl;
  static late String environmentName;

  static late Environment _environment;

  static Environment get environment => _environment;

  static void setUpEnv(Environment environment) {
    _environment = environment;

// for get aab for prod flutter build appbundle --flavor prod -t lib/main_prod.dart

    switch (environment) {
      case Environment.development:
        baseUrl = dotenv.env['API_DEV_BASE_URL']!;
        environmentName = "DEV";
        break;

      case Environment.production:
        baseUrl = dotenv.env['API_PROD_BASE_URL']!;
        environmentName = "PROD";
        break;
    }
  }
}
