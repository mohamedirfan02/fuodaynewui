import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_recent_employees_card.dart';
import 'package:provider/provider.dart';
import '../provider/hr_overview_provider.dart';

class HRViewRecentEmployeesWidget extends StatelessWidget {
  const HRViewRecentEmployeesWidget({super.key, required HROverviewEntity hrOverview});

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
        return HRRecentEmployeesCard(
          leadingEmployeeFirstLetter: e.name.isNotEmpty ? e.name[0] : '',
          employeeName: e.name,
          employeeDesignation: e.role,
          employeeJoinDate: e.dateOfJoining,
         // profilePhotoUrl: e.profilePhoto,
        );
      },
    );
  }
}
