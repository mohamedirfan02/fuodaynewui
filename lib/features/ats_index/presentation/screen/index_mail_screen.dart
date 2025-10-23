import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_filter_button.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
// import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/gmail_compose_index.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/router/app_route_constants.dart';

class AtsIndexMailScreen extends StatefulWidget {
  const AtsIndexMailScreen({super.key});

  @override
  State<AtsIndexMailScreen> createState() => _AtsIndexMailScreenState();
}

class _AtsIndexMailScreenState extends State<AtsIndexMailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute = AppRouteConstants.atsIndexScreen;
  Widget _buildEmailCard({
    required bool isReceived,
    required String senderName,
    required String senderPhoto,
    required String time,
    required String subject,
    required String message,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: AppColors.greyColor.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with sender/receiver info
          Row(
            children: [
              // Label badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isReceived
                      ? Colors.green.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: KText(
                  text: isReceived ? "Received" : "Sent",
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: isReceived ? Colors.green : Colors.blue,
                ),
              ),
              SizedBox(width: 12.w),
              KText(
                text: isReceived ? "From" : "To",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.titleColor,
              ),
              SizedBox(width: 12.w),
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: senderPhoto.isNotEmpty
                    ? NetworkImage(senderPhoto)
                    : null,
                child: senderPhoto.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 16.r,
                        color: Colors.grey.shade600,
                      )
                    : null,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: KText(
                  text: senderName,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.titleColor,
                ),
              ),
              KText(
                text: time,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.greyColor.withOpacity(0.2), thickness: 1),
          SizedBox(height: 16.h),
          // Subject
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Subject :",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.titleColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: KText(
                  text: subject,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.titleColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.greyColor.withOpacity(0.2), thickness: 1),
          SizedBox(height: 16.h),
          // Message body
          KText(
            text: message,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.titleColor,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.atsHomepageBg,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(18.47.w),
                decoration: BoxDecoration(color: AppColors.secondaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 20.w,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: width * 0.06,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: profilePhoto.isNotEmpty
                              ? NetworkImage(profilePhoto)
                              : null,
                          child: profilePhoto.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: width * 0.06,
                                  color: Colors.grey.shade600,
                                )
                              : null,
                        ),
                        // Start Date
                        Column(
                          children: [
                            KText(
                              text: "Pristia Candra",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            KText(
                              text: "UI/UX Designer",
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ],
                        ),

                        // Export file
                        Expanded(
                          child: KAtsGlowButton(
                            text: "Profile",
                            textColor: AppColors.greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            icon: SvgPicture.asset(
                              AppAssetsConstants.atsUserIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            onPressed: () {},
                            backgroundColor: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Email Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.greyColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // To section
                    Row(
                      children: [
                        KText(
                          text: "To",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.titleColor,
                        ),
                        SizedBox(width: 24.w),
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: profilePhoto.isNotEmpty
                              ? NetworkImage(profilePhoto)
                              : null,
                          child: profilePhoto.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 16.r,
                                  color: Colors.grey.shade600,
                                )
                              : null,
                        ),
                        SizedBox(width: 8.w),
                        KText(
                          text: "Pristia Candra",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.titleColor,
                        ),
                        Spacer(),
                        KText(
                          text: "Nov12,2:55",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.greyColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Divider(
                      color: AppColors.greyColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    SizedBox(height: 16.h),
                    // Subject
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Subject :",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.titleColor,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: KText(
                            text:
                                "Thank you for your application at Pixel Office",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.titleColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Divider(
                      color: AppColors.greyColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    SizedBox(height: 16.h),
                    // Message body
                    KText(
                      text: "Hi Cecilia,",
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                    ),
                    SizedBox(height: 12.h),
                    KText(
                      text:
                          "The main duties of a Senior Product Designer include conducting user research and testing, creating wireframes and prototypes, developing design systems, collaborating with cross-functional teams (such as developers, product managers, and other designers),",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                      //    height: 1.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            height: 40.h,
            width: double.infinity,
            text: "Send Message",
            fontSize: 14.sp,
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
                    expand: true,
                    initialChildSize: 0.9,
                    // covers ~90% of the screen
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
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
                          child: const ComposeEmailScreen(), // ✅ Embedded here
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
