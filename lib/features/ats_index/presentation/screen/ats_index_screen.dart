import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

class AtsIndexScreen extends StatefulWidget {
  const AtsIndexScreen({super.key});

  @override
  State<AtsIndexScreen> createState() => _AtsIndexScreenState();
}

class _AtsIndexScreenState extends State<AtsIndexScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute =
      AppRouteConstants.atsIndexScreen; // Replace with actual current route

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
      bottomSheet: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            height: 24.h,
            width: double.infinity,
            text: "Send Message",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom +
                          20.h, // keyboard aware
                      top: 10.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Drag handle
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 2.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),

                          KVerticalSpacer(height: 12.h),

                          // Create Ticket
                          KText(
                            text: "Index",
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                          ),

                          KVerticalSpacer(height: 10.h),

                          // Employee name
                          KDropdownTextFormField<String>(
                            hintText: "Select Templates",
                            value: context.dropDownProviderWatch.getValue(
                              'leaveType',
                            ),
                            items: [
                              'Welcome Email',
                              'Newsletter',
                              'Saying thank you',
                              'Promotion Email',
                            ],
                            onChanged: (value) => context.dropDownProviderRead
                                .setValue('emailTemplate', value),
                          ),
                          KVerticalSpacer(height: 10.h),
                          KText(
                            text: "Subject *",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                          KVerticalSpacer(height: 10.h),
                          KAuthTextFormField(
                            maxLines: 3,
                            hintText:
                                'Thank you for your application at Pixel Office',
                            // controller: empIdController,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icons.card_travel_rounded,
                            isReadOnly: false,
                          ),
                          KVerticalSpacer(height: 10.h),

                          // ui for edit like gmail
                          KAuthTextFormField(
                            hintText: "",
                            onTap: () async {},
                            //  controller: fromDateMonthYearController,
                            //keyboardType: TextInputType.datetime,
                            suffixIcon: Icons.alternate_email,
                          ),
                          KVerticalSpacer(height: 10.h),

                          KAuthTextFormField(
                            maxLines: 8,
                            hintText: "Regulation Reason",
                            //   controller: regulationReasonController,
                            keyboardType: TextInputType.text,
                            suffixIcon: Icons.category_rounded,
                          ),
                          KVerticalSpacer(height: 10.h),
                          // Cancel
                          KAuthFilledBtn(
                            height: 24.h,
                            width: double.infinity,
                            text: "Cancel",
                            fontSize: 10.sp,
                            textColor: AppColors.primaryColor,
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            backgroundColor: AppColors.primaryColor.withOpacity(
                              0.4,
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // Submit
                          KAuthFilledBtn(
                            height: 24.h,
                            fontSize: 10.sp,
                            width: double.infinity,
                            text: "Send Message",
                            textColor: AppColors.secondaryColor,
                            onPressed: () {},
                            // Updated to use the new submit method
                            backgroundColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            fontSize: 11.sp,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.atsHomepageBg,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Home Page Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KText(
                        text: "Index",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: AppColors.titleColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
