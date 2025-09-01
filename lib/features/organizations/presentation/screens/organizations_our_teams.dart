import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/organizations/presentation/providers/DepartmentListProvider.dart';
import 'package:fuoday/features/organizations/presentation/widgets/organizations_team_designation_member_count_heading.dart';
import 'package:fuoday/features/organizations/presentation/widgets/organizations_team_member_tile.dart';
import 'package:provider/provider.dart';

class OrganizationsOurTeams extends StatefulWidget {
  const OrganizationsOurTeams({super.key});

  @override
  State<OrganizationsOurTeams> createState() => _OrganizationsOurTeamsState();
}

class _OrganizationsOurTeamsState extends State<OrganizationsOurTeams> {
  @override
  void initState() {
    super.initState();

    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();

    if (webUserId != null) {
      final provider = context.read<DepartmentListProvider>();
      provider.fetchDepartmentList(webUserId);
    } else {
      // Handle the case when webUserId is null
      debugPrint("⚠️ webUserId is null. Cannot fetch department list.");
    }
  }



  @override
  Widget build(BuildContext context) {
    final departmentProvider = context.watch<DepartmentListProvider>();


    if (departmentProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (departmentProvider.error != null) {
      return Center(child: Text('Error: ${departmentProvider.error}'));
    }

    final departments = departmentProvider.departments;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Our Teams",
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              textAlign: TextAlign.start,
              color: AppColors.primaryColor,
              isUnderline: true,
              underlineColor: AppColors.primaryColor,
            ),
            KVerticalSpacer(height: 14.h),

            // Corrected iteration over the map
            ...departments.entries.map((entry) {
              final departmentName = entry.key;
              final members = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrganizationsTeamDesignationMemberCountHeading(
                    teamDesignation: departmentName,
                    teamTotalMemberCount: members.length.toString(),
                  ),
                  KVerticalSpacer(height: 10.h),
                  ...members.map(
                        (member) => OrganizationsTeamMemberTile(
                      leadingAvatarBgColor: AppColors.primaryColor,
                      teamMemberNameFirstLetter: member.name.isNotEmpty ? member.name[0] : '',
                      teamMemberName: member.name,
                      teamMemberDesignation: member.designation,
                    ),
                  ).toList(),
                  KVerticalSpacer(height: 14.h),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

