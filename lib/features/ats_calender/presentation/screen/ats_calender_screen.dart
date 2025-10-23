import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
// import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/router/app_route_constants.dart';

class AtsCalenderScreen extends StatefulWidget {
  const AtsCalenderScreen({super.key});

  @override
  State<AtsCalenderScreen> createState() => _AtsCalenderScreenState();
}

class _AtsCalenderScreenState extends State<AtsCalenderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute = AppRouteConstants.atsCalendarScreen;

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    return PopScope(
      canPop: false, // Prevent default pop
      onPopInvokedWithResult: (didPop, result) async {
        // If not popped automatically
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
            // If already on Home → allow exiting app
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AtsKAppBarWithDrawer(
          userName: "",
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: "",
          showUserInfo: true,
          onDrawerPressed: _openDrawer,
          onNotificationPressed: () {},
        ),
        drawer: KAtsDrawer(
          userEmail: email,
          userName: name,
          profileImageUrl: profilePhoto,
          currentRoute: currentRoute, // This will highlight the current screen
        ),
      ),
    );
  }
}
