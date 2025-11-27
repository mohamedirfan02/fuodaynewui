import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_audit_form.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_employee_audit_form.dart';
import 'package:fuoday/features/performance/presentation/screens/performance_summary.dart';
import 'package:fuoday/core/service/hive_storage_service.dart'; // <-- Make sure you import
import 'package:go_router/go_router.dart';

class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeDetails = HiveStorageService().employeeDetails ?? {};
    final designation = (employeeDetails['designation'] ?? '').toString();

    // Check role
    // Roles allowed to see Employee Audit Form
    final allowedDesignations = [
      "assistant manager-it",
      "founder & ceo",
    ];
    final isAllowed = allowedDesignations.contains(designation.toLowerCase());

    // Build tab list dynamically
    final List<Tab> tabs = [
      const Tab(text: "Performance Summary"),
      const Tab(text: "Audit Form"),
    ];

    final List<Widget> tabViews = [
      const PerformanceSummary(),
      const PerformanceAuditForm(),
    ];

    // Add Employee Audit Form tab only for allowed designations
    if (isAllowed) {
      tabs.add(const Tab(text: "Employee Audit Form"));
      tabViews.add(const PerformanceEmployeeAuditForm());
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: KAppBar(
          title: "Performance",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Tab Bar
              KTabBar(tabs: tabs),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(children: tabViews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
