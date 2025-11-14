import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/gmail_compose_index.dart';
import 'package:fuoday/features/ats_support/presentation/widgets/k_details.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';

class TicketViewScreen extends StatefulWidget {
  const TicketViewScreen({super.key});

  @override
  State<TicketViewScreen> createState() => _TicketViewScreenState();
}

class _TicketViewScreenState extends State<TicketViewScreen> {
  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Support Center",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "Manage Tickets",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Notifications coming soon")),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 20),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TicketDetailInfo(
              user: 'Brentrodriguez',
              phoneNumber: "Can't update the app",
              ticketStatus: 'In Progress',
              priorityLevel: 'High',
              subject: "Can't update the app",
              submitted: 'Mar 3, 2022',
              ticketId: '1234',
              department: 'Information technology',
            ),
            KVerticalSpacer(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: KText(
                text: "Status",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.atsTittleText,
              ),
            ),
            KVerticalSpacer(height: 10.h),
            // Type Drop Down TextForm Field
            KDropdownTextFormField<String>(
              hintText: "Select Status",
              value: context.dropDownProviderWatch.getValue('leaveType'),
              items: ['IN Progress', 'Completed', 'Pending'],
              onChanged: (value) =>
                  context.dropDownProviderRead.setValue('leaveType', value),
            ),
            KVerticalSpacer(height: 16.h),
            Container(
              width: 343.w,
              height: isTablet ? (isLandscape ? 255.h : 248.h) : 248.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: "Govlog",
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      color: AppColors.atsTittleText,
                    ),
                    KVerticalSpacer(height: 24.h),
                    KText(
                      text:
                          "Why can’t I update the app? It keeps reloading the same page. Please help.",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.atsTittleText,
                    ),
                    KVerticalSpacer(height: 50.h),
                    SvgPicture.asset(
                      AppAssetsConstants.ticketIcon,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: KText(
                        text: "20:00",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            KVerticalSpacer(height: 16.h),

            Container(
              width: 343.w,
              height: isTablet ? (isLandscape ? 280.h : 248.h) : 248.h,
              decoration: BoxDecoration(
                color: AppColors.chatBg,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssetsConstants.atsUserIcon,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20),
                        KText(
                          text: "Deanna Jones",
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          color: AppColors.atsTittleText,
                        ),
                      ],
                    ),
                    KVerticalSpacer(height: 24.h),
                    KText(
                      text:
                          "Hi, Deanna here. Have you tried turning your phone off and on again?",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.atsTittleText,
                    ),
                    KVerticalSpacer(height: 50.h),
                    SvgPicture.asset(
                      AppAssetsConstants.ticketIcon,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: KText(
                        text: "20:00",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            icon: SvgPicture.asset(
              AppAssetsConstants.addIcon,
              height: 16,
              width: 16,
              fit: BoxFit.contain,
            ),
            text: "Add Response",
            fontSize: 12.sp,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.9,
                    // covers ~90% of the screen
                    minChildSize: 0.5,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20.h,
                            top: 10.h,
                          ),
                          child: Column(
                            children: [
                              // ===== Top handle =====
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: 50,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                              const ComposeEmailScreen(),
                            ],
                          ), // ✅ Embedded here
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
