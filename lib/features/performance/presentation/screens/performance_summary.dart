import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/performance/presentation/widgets/performance_card.dart';
import 'package:intl/intl.dart';

class PerformanceSummary extends StatefulWidget {
  const PerformanceSummary({super.key});

  @override
  State<PerformanceSummary> createState() => _PerformanceSummaryState();
}

class _PerformanceSummaryState extends State<PerformanceSummary> {
  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;
  final dateFormatter = DateFormat('yyyy-MM-dd'); // or 'dd-MM-yyyy'

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() {
      context.performanceSummaryProviderRead.loadSummary(webUserId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final provider = context.performanceSummaryProviderWatch;
    // Columns
    final columns = [
      'Date',
      'Task',
      'Assigned By',
      'Deadline',
      'Status',
      'Progress Note',
    ];
    // instead of hardcoding
    final data =
        provider.summary?.tasks?.map((task) {
          return {
            //'S.No': task.id.toString(),
            'Date': task.date != null ? dateFormatter.format(task.date!) : '',
            'Task': task.description ?? '',
            'Assigned By': task.assignedBy ?? '',
            'Deadline': task.deadline != null
                ? dateFormatter.format(task.deadline!)
                : '',
            'Status': task.status ?? '',
            'Progress Note': task.progressNote ?? '',
          };
        }).toList() ??
        [];

    // Performance Summary Card
    final performanceSummaryCard = [
      {
        'iconData': Icons.speed,
        'cardTitle': "Performance Score",
        'cardSubTitle':
            provider.summary?.performanceScore?.toString() ??
            "No Performance Score",
      },
      {
        'iconData': Icons.show_chart,
        'cardTitle': "Goal Progress",
        'cardSubTitle':
            "${provider.summary?.goalProgressPercentage?.toStringAsFixed(1) ?? '0'}%",
      },
      {
        'iconData': Icons.star_rate,
        'cardTitle': "Performance Ratings",
        'cardSubTitle':
            "${provider.summary?.performanceRatingOutOf5?.toString() ?? '0'}/5",
      },
      {
        'iconData': Icons.calendar_today,
        'cardTitle': "Avg. Monthly Attendance",
        'cardSubTitle':
            "${provider.summary?.averageMonthlyAttendance?.toStringAsFixed(1) ?? '0'}%",
      },
    ];

    // Current Goals Card
    final currentGoalsCard = [
      {
        'iconData': Icons.speed,
        'cardTitle': "Completed Tasks",
        'cardSubTitle':
            provider.summary?.completedTasks?.length.toString() ?? "0",
      },
      {
        'iconData': Icons.show_chart,
        'cardTitle': "Completed Projects",
        'cardSubTitle':
            provider.summary?.completedProjects?.length.toString() ?? "0",
      },
      {
        'iconData': Icons.star_rate,
        'cardTitle': "Pending Goals",
        'cardSubTitle':
            provider.summary?.pendingGoals?.length.toString() ?? "0",
      },
      {
        'iconData': Icons.calendar_today,
        'cardTitle': "Upcoming Projects",
        'cardSubTitle':
            provider.summary?.upcomingProjects?.length.toString() ?? "0",
      },
    ];

    AppLoggerHelper.logInfo(performanceSummaryCard.toString());
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KText(
            text: "Good Afternoon, Mohammed Irfan",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: isTablet ? (isLandscape ? 4.8 : 2.5) : 1.0,
            ),
            itemCount: performanceSummaryCard.length,
            itemBuilder: (context, index) {
              final data = performanceSummaryCard[index];
              return PerformanceCard(
                iconData: data['iconData'] as IconData,
                cardTitle: data['cardTitle'] as String,
                cardSubTitle: data['cardSubTitle'] as String,
              );
            },
          ),

          KVerticalSpacer(height: 12.h),

          KText(
            text: "Current Goals",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10, // Horizontal spacing between items
              mainAxisSpacing: 10, // Vertical spacing between items
              childAspectRatio: isTablet
                  ? (isLandscape ? 4.8 : 2.5)
                  : 1.0, // Aspect ratio of each item (width/height)
            ),
            itemCount: currentGoalsCard.length,
            // Total number of items
            itemBuilder: (context, index) {
              final data = currentGoalsCard[index];
              return PerformanceCard(
                iconData: data['iconData'] as IconData,
                cardTitle: data['cardTitle'] as String,
                cardSubTitle: data['cardSubTitle'] as String,
              );
            },
          ),

          KVerticalSpacer(height: 12.h),

          KText(
            text: "Goals Processing Tracking",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          // Table
          SizedBox(
            height: 600.h,
            child: KDataTable(columnTitles: columns, rowData: data),
          ),

          KVerticalSpacer(height: 60.h),
        ],
      ),
    );
  }
}
