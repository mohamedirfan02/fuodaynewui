import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';

class AtsJobPortalScreen extends StatefulWidget {
  const AtsJobPortalScreen({super.key});

  @override
  State<AtsJobPortalScreen> createState() => _AtsJobPortalScreenState();
}

class _AtsJobPortalScreenState extends State<AtsJobPortalScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute = AppRouteConstants.atsJobPortalScreen; // Replace with actual current route

  @override
  Widget build(BuildContext context) {

    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    return Scaffold(
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

    );
  }
}
