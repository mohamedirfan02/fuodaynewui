import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      final storage = HiveStorageService();

      final isOnBoarded = storage.isOnBoardingInStatus;
      final isLoggedIn = storage.isAuthLoggedStatus;

      if (isOnBoarded && isLoggedIn) {
        // Show employee bottom nav
        GoRouter.of(
          context,
        ).pushReplacementNamed(AppRouteConstants.employeeBottomNav);
      } else if (isOnBoarded && !isLoggedIn) {
        // Show login screen
        GoRouter.of(context).pushReplacementNamed(AppRouteConstants.login);
      } else {
        // Show get started (onboarding) screen
        GoRouter.of(context).pushReplacementNamed(AppRouteConstants.onBoarding);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Center(
          child: Image.asset(
            AppAssetsConstants.logo,
            height: 200.h,
            width: 200.w,
           // fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
