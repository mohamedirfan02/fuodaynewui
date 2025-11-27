import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/management/presentation/widgets/management_recent_employees_card.dart';
import 'package:provider/provider.dart';

class ManagementViewRecentEmployees extends StatelessWidget {
  const ManagementViewRecentEmployees({super.key,required HROverviewEntity hrOverview});

  @override
  Widget build(BuildContext context) {
    final employees = context.watch<HROverviewProvider>().hrOverview!.recentEmployees;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: employees.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final e = employees[index];
        KVerticalSpacer(height: 20.h);

        return ManagementRecentEmployeesCard(
          leadingEmployeeFirstLetter: e.name.isNotEmpty ? e.name[0] : '',
          employeeName: e.name,
          employeeDesignation: e.role,
          employeeJoinDate: e.dateOfJoining,
        );
      },
    );
  }
}
