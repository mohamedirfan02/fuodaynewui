import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/teams/presentation/widgets/k_team_direct_report_tile.dart';

class TeamsReportees extends StatefulWidget {
  const TeamsReportees({super.key});

  @override
  State<TeamsReportees> createState() => _TeamsReporteesState();
}

class _TeamsReporteesState extends State<TeamsReportees> {
  @override
  void initState() {
    super.initState();
    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        // ✅ use TeamMembersProvider
        context.teamMemberProviderRead.fetchTeamMembers(webUserId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // ✅ TeamMembersProvider
    final teamMembersProvider = context.teamMemberProviderWatch;
    final internetCheckerProvider = context.appInternetCheckerProviderWatch;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!internetCheckerProvider.isNetworkConnected) {
        KSnackBar.failure(context, "No Internet Connection");
      } else {
        KSnackBar.success(context, "Internet Connection Available");
      }
    });

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KVerticalSpacer(height: 20.h),

          KText(
            text: "Direct Report",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color:
                theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
          ),

          KVerticalSpacer(height: 12.h),

          if (teamMembersProvider.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (teamMembersProvider.error != null)
            Expanded(
              child: Center(child: Text('❌ ${teamMembersProvider.error}')),
            )
          else if (teamMembersProvider.teamMembers.isEmpty)
            const Expanded(
              child: Center(child: Text('No direct reports available.')),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: teamMembersProvider.teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembersProvider.teamMembers[index];
                  return KTeamDirectReportTile(
                    personName: member.name,
                    personRole: member.designation,
                    personContact: member.department,
                    avatarPersonFirstLetter: member.name.isNotEmpty
                        ? member.name[0]
                        : '?',
                    avatarBgColor: theme.primaryColor,
                  );
                },
                separatorBuilder: (context, index) =>
                    KVerticalSpacer(height: 10.h),
              ),
            ),
        ],
      ),
    );
  }
}
