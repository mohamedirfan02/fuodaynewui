import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';

class TeamsList extends StatefulWidget {
  const TeamsList({super.key});

  @override
  State<TeamsList> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  @override
  void initState() {
    super.initState();
    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();
    if (webUserId != null) {
      Future.microtask(() {
        context.teamMemberProviderRead.fetchTeamMembers(webUserId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.teamMemberProviderWatch;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text('❌ ${provider.error}'));
    }

    final columns = [
      'Employee ID',
      'Name',
      'Location',
      'Email Address',
      'Department',
      'Designation',
    ];

    final rowData = provider.teamMembers.map((e) {
      return {
        'Employee ID': e.empId,
        'Name': e.name,
        'Location': e.location,
        'Email Address': e.email,
        'Department': e.department,
        'Designation': e.designation,
      };
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            KVerticalSpacer(height: 20.h),
            SizedBox(
              height: 400.h,
              child: KDataTable(columnTitles: columns, rowData: rowData),
            ),
          ],
        ),
      ),
    );
  }
}
