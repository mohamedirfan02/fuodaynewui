import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/domain/entities/home_feeds_project_data_entity.dart';
import 'package:fuoday/features/home/domain/usecases/get_home_feeds_project_data_use_case.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_employee_feeds_assigned_works_tile.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_employee_feeds_pending_works_tile.dart';

class HomeEmployeeFeeds extends StatefulWidget {
  const HomeEmployeeFeeds({super.key});

  @override
  State<HomeEmployeeFeeds> createState() => _HomeEmployeeFeedsState();
}

class _HomeEmployeeFeedsState extends State<HomeEmployeeFeeds> {
  late Future<HomeFeedsProjectDataEntity> _homeFeedsFuture;

  @override
  void initState() {
    super.initState();
    final hiveService = getIt<HiveStorageService>();
    final webUserId = hiveService.employeeDetails?['web_user_id']?.toString();

    final useCase = getIt<GetHomeFeedsProjectDataUseCase>();
    _homeFeedsFuture = useCase.call(webUserId!);
  }

  void _onUpdateProgress(dynamic item) {
    // Handle update progress command
    _showUpdateProgressDialog(item);
  }

  //isTablet? (isLandscape ? 30.h : 25.h) : 22.h,
  void _showUpdateProgressDialog(dynamic item) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    final TextEditingController progressNoteController =
        TextEditingController();
    final TextEditingController commandController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          //App Theme Data
          final theme = Theme.of(context);
          // Calculate available height considering keyboard
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          final availableHeight =
              constraints.maxHeight - keyboardHeight - 40; // 40 for padding

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: BoxConstraints(maxHeight: availableHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Fixed Header
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: KText(
                            text: 'Update Your Task',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            // color: AppColors.titleColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, size: 20.sp),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Dropdown
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Status',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                // color: AppColors.titleColor,
                              ),
                              SizedBox(height: 8.h),
                              KDropdownTextFormField<String>(
                                hintText: "Priority",
                                value: context.dropDownProviderWatch.getValue(
                                  'status',
                                ),
                                items: ['Pending', 'In Progress', 'Completed'],
                                onChanged: (value) => context
                                    .dropDownProviderRead
                                    .setValue('status', value),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Progress Note
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),
                              KAuthTextFormField(
                                maxLines: 2,
                                label: "Progress Note",
                                controller: progressNoteController,
                                hintText: "Enter Progress Note",
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Command
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.h),
                              KAuthTextFormField(
                                maxLines: 5,
                                label: "Command",
                                controller: commandController,
                                hintText: "Enter Command",
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),

                  // Fixed Button
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: KAuthFilledBtn(
                      text: "Update",
                      onPressed: () async {
                        final hiveService = getIt<HiveStorageService>();
                        final webUserId =
                            hiveService.employeeDetails?['web_user_id'];
                        final useCase = getIt<GetHomeFeedsProjectDataUseCase>();
                        final status =
                            context.dropDownProviderRead.getValue('status') ??
                            "Pending";
                        setState(() {
                          _homeFeedsFuture = useCase.call(webUserId!);
                        });
                        Navigator.pop(context);

                        await _updateTask(
                          taskId: item.id
                              .toString(), // ensure your `item` has taskId
                          webUserId: int.parse(
                            webUserId.toString(),
                          ), // fix here
                          status: status,
                          progress: progressNoteController.text.trim(),
                          comment: commandController.text.trim(),
                        );
                      },
                      backgroundColor: AppColors.primaryColor,
                      fontSize: 10.sp,
                      height: isTablet ? (isLandscape ? 30.h : 25.h) : 22.h,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommandSection(dynamic item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDark
            ? Color(0xFF2A2D32) // dark background
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isDark
              ? Color(0xFF3A3F45) // dark border
              : Colors.grey[300]!,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                size: 12.sp,
                color:
                    theme.inputDecorationTheme.focusedBorder?.borderSide.color,
              ),
              SizedBox(width: 4.w),
              KText(
                text: 'Comment Section',
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: theme
                    .inputDecorationTheme
                    .focusedBorder
                    ?.borderSide
                    .color, //AppColors.subTitleColor,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: [
              _buildCommandButton(
                'Click to Update',
                Icons.update,
                theme.primaryColor,
                () => _onUpdateProgress(item),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommandButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: color.withOpacity(0.3), width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12.sp, color: color),
            SizedBox(width: 3.w),
            KText(
              text: label,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTask({
    required String taskId,
    required int webUserId,
    required String status,
    required String progress,
    required String comment,
  }) async {
    final dio = DioService().client;

    try {
      final response = await dio.post(
        AppApiEndpointConstants.updateTasks,
        data: {
          "task_id": taskId,
          "web_user_id": webUserId,
          "status": status.toLowerCase(), // completed / pending / in progress
          "progress": progress,
          "comment": comment,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.statusMessage}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          theme.secondaryHeaderColor, //Theme.of(context).secondaryHeaderColor
      body: FutureBuilder<HomeFeedsProjectDataEntity>(
        future: _homeFeedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data found."));
          }

          final assigned = snapshot.data!.assigned;
          final pending = snapshot.data!.pending;

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              // Assigned Works
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? [
                            Color(0xFF2E323A),
                            Color(0xFF3A3F47),
                            Color(0xFF4A4F57),
                          ]
                        : [Color(0xFFD1D7E8), Color(0xFFEFF1F7), Colors.white],
                  ),
                  border: Border.all(
                    color:
                        theme.textTheme.headlineLarge?.color ??
                        AppColors.titleColor,
                    width: 0.2.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: KText(
                        text: 'Assigned Works By You',
                        fontWeight: FontWeight.w600,
                        color: theme
                            .inputDecorationTheme
                            .focusedBorder
                            ?.borderSide
                            .color,
                        fontSize: 12.sp,
                      ),
                    ),
                    assigned.isEmpty
                        ? Center(child: Text("No assigned works"))
                        : ListView.separated(
                            shrinkWrap:
                                true, // ✅ allow it to take only required space
                            physics:
                                NeverScrollableScrollPhysics(), // ✅ disable inner scroll
                            itemCount: assigned.length,
                            separatorBuilder: (_, __) =>
                                KVerticalSpacer(height: 8.h),
                            itemBuilder: (context, index) {
                              final item = assigned[index];
                              return KHomeEmployeeFeedsAssignedWorksTile(
                                leadingVerticalDividerColor: theme.primaryColor,
                                assignedWorksTitle: item.projectName,
                                assignedWorkSubTitle: item.description,
                                assignedWorkDeadLine: item.deadline,
                                assignedBy: item.assignedBy,
                                assignedTo: item.assignedTo,
                                date: item.date,
                                progress: item.progress,
                                deadline: item.deadline,
                                progressNote: item.progressNote,
                                command: item.comment,
                              );
                            },
                          ),
                  ],
                ),
              ),

              KVerticalSpacer(height: 14.h),

              // Pending Works
              Container(
                padding: EdgeInsets.only(bottom: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? const [
                            Color(0xFF2E323A),
                            Color(0xFF3A3F47),
                            Color(0xFF4A4F57),
                          ]
                        : [Color(0xFFD1D7E8), Color(0xFFEFF1F7), Colors.white],
                  ),
                  border: Border.all(color: AppColors.titleColor, width: 0.2.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        top: 10.h,
                        bottom: 10.h,
                      ),
                      child: KText(
                        text: 'Pending Works',
                        fontWeight: FontWeight.w600,
                        color: theme
                            .inputDecorationTheme
                            .focusedBorder
                            ?.borderSide
                            .color,
                        fontSize: 12.sp,
                      ),
                    ),
                    pending.isEmpty
                        ? Center(child: Text("No pending works"))
                        : ListView.separated(
                            shrinkWrap: true, // ✅ take only needed height
                            physics:
                                NeverScrollableScrollPhysics(), // ✅ disable inner scroll
                            itemCount: pending.length,
                            separatorBuilder: (_, __) =>
                                KVerticalSpacer(height: 8.h),
                            itemBuilder: (context, index) {
                              final item = pending[index];
                              return Column(
                                children: [
                                  KHomeEmployeeFeedsPendingWorksTile(
                                    pendingVerticalDividerColor:
                                        theme.primaryColor,
                                    pendingProjectTitle: item.projectName,
                                    pendingDeadline: item.deadline,
                                    pendingWorkStatus: item.progress,
                                    assignedBy: item.assignedBy,
                                    date: item.date,
                                    description: item.description,
                                    progressNote: item.progressNote,
                                    comment: item.comment,
                                  ),
                                  _buildCommandSection(item),
                                ],
                              );
                            },
                          ),
                  ],
                ),
              ),

              KVerticalSpacer(height: 14.h),
            ],
          );
        },
      ),
    );
  }
}
