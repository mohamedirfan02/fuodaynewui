import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:go_router/go_router.dart';

//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 2), () {
//       final storage = HiveStorageService();
//
//       final isOnBoarded = storage.isOnBoardingInStatus;
//       final isLoggedIn = storage.isAuthLoggedStatus;
//
//       debugPrint("🟢 isOnBoarded: $isOnBoarded | isLoggedIn: $isLoggedIn");
//
//       if (isOnBoarded && isLoggedIn) {
//         // Show employee bottom nav
//         GoRouter.of(
//           context,
//         ).pushReplacementNamed(AppRouteConstants.employeeBottomNav);
//       } else if (isOnBoarded && !isLoggedIn) {
//         // Show login screen
//         GoRouter.of(context).pushReplacementNamed(AppRouteConstants.login);
//       } else {
//         // Show get started (onboarding) screen
//         GoRouter.of(context).pushReplacementNamed(AppRouteConstants.onBoarding);
//       }
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Center(
//           child: Image.asset(
//             AppAssetsConstants.logo,
//             height: 200.h,
//             width: 200.w,
//             // fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<bool> _validateSecureStorage(HiveStorageService storage) async {
    try {
      // Try reading secure data
      await storage.secureStorage.read(key: "authToken");
      return true;
    } catch (e) {
      debugPrint("❌ Secure Storage Corrupted: $e");
      return false;
    }
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final storage = HiveStorageService();

    // 🔥 Step 1: Validate secure storage (fix BAD_DECRYPT)
    final isSecureDataValid = await _validateSecureStorage(storage);

    if (!isSecureDataValid) {
      // corrupted keystore → clear all
      await storage.clearAll();
    }

    final isOnBoarded = storage.isOnBoardingInStatus;
    final isLoggedIn = storage.isAuthLoggedStatus;
    final userRole = storage.userRole;

    debugPrint(
      "🟢 isOnBoarded: $isOnBoarded | isLoggedIn: $isLoggedIn | userRole: $userRole",
    );

    // Navigation Logic
    if (isOnBoarded && isLoggedIn) {
      if (userRole == "recruiter") {
        GoRouter.of(
          context,
        ).pushReplacementNamed(AppRouteConstants.homeRecruiter);
      } else {
        GoRouter.of(
          context,
        ).pushReplacementNamed(AppRouteConstants.employeeBottomNav);
      }
    } else if (isOnBoarded && !isLoggedIn) {
      GoRouter.of(context).pushReplacementNamed(AppRouteConstants.login);
    } else {
      GoRouter.of(context).pushReplacementNamed(AppRouteConstants.onBoarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssetsConstants.logo,
          height: 200.h,
          width: 200.w,
        ),
      ),
    );
  }
}
