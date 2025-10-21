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

  Future<void> _navigate() async {
    // Wait a little to mimic splash delay
    await Future.delayed(const Duration(seconds: 2));

    final storage = HiveStorageService();
    final isOnBoarded = storage.isOnBoardingInStatus;
    final isLoggedIn = storage.isAuthLoggedStatus;
    final userRole = storage.userRole; // "employee" or "recruiter"

    debugPrint(
      "🟢 isOnBoarded: $isOnBoarded | isLoggedIn: $isLoggedIn | userRole: $userRole",
    );

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
