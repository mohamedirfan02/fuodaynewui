import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';

class HomeRecruiterScreen extends StatefulWidget {
  const HomeRecruiterScreen({super.key});

  @override
  State<HomeRecruiterScreen> createState() => _HomeRecruiterScreenState();
}

class _HomeRecruiterScreenState extends State<HomeRecruiterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    // Grid Attendance Data
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': Icons.person,
        'title': 'Opening Position',
        'numberOfCount': "3,540",
        'growth': "+5.1%",
      },
      {
        'title': 'Total Closed Position',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Total Employee',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Shortlisted',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'On hold',
        'numberOfCount': "562",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Onboarding',
        'numberOfCount': "850",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
    ];

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
      drawer: KDrawer(
        userEmail: email,
        userName: name,
        profileImageUrl: profilePhoto,
      ),
      body: KLinearGradientBg(
        gradientColor: AppColors.cardGradientColor,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column( // ✅ FIX: wrap multiple children
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.15,
                  ),
                  itemCount: gridAttendanceData.length,
                  itemBuilder: (context, index) {
                    final item = gridAttendanceData[index];
                    return AtsTotalCountCard(
                      attendanceCount: item['numberOfCount'].toString(),
                      attendanceCardIcon: item['icon'],
                      attendanceDescription: item['title'],
                      attendanceIconColor: AppColors.primaryColor,
                      attendancePercentageColor: AppColors.checkInColor,
                      growthText: item['growth'],
                    );
                  },
                ),

                SizedBox(height: 24.h),

                RequirementStatsCard(
                  dataMap: {
                    "Pending": 36,
                    "Unactive": 6,
                    "Closed": 13,
                  },
                  colorMap: {
                    "Pending": Colors.purple,
                    "Unactive": Colors.orange,
                    "Closed": Colors.teal,
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
