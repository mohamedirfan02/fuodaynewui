import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/gmail_compose_index.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';

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
    //App Theme Data
    final theme = Theme.of(context);
    //  final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
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
                      ? theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.2,
                        ) //AppColors.greyColor,
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
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    //For Empty Avatar Initial purpose
    String _getInitials(String name) {
      if (name.trim().isEmpty) return "";
      List<String> parts = name.trim().split(" ");
      if (parts.length == 1) {
        return parts[0].substring(0, 1).toUpperCase();
      } else {
        return (parts[0].substring(0, 1) + parts[1].substring(0, 1))
            .toUpperCase();
      }
    }

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
        color: theme.cardColor, //ATS Background Color
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(color: theme.secondaryHeaderColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        // spacing: 16.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: width * 0.06,
                            backgroundColor: AppColors.checkInColor.withValues(
                              alpha: 0.1,
                            ),
                            backgroundImage: profilePhoto.isNotEmpty
                                ? NetworkImage(profilePhoto)
                                : null,
                            child: profilePhoto.isEmpty
                                ? KText(
                                    text: "PC",
                                    fontWeight: FontWeight.w600,
                                    fontSize: width * 0.035,
                                    color: AppColors.checkInColor,
                                  )
                                : null,
                          ),
                          // Start Date
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Pristia Candra",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              KText(
                                text: "lincoln@unpixel.com",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              KText(
                                text: "UI/UX Designer",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          Spacer(),
                          // Export file
                          KAtsGlowButton(
                            text: "Profile",
                            textColor:
                                theme.textTheme.bodyLarge?.color ??
                                AppColors.greyColor, //AppColors.greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            icon: SvgPicture.asset(
                              AppAssetsConstants.atsUserIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                              //SVG IMAGE COLOR
                              colorFilter: ColorFilter.mode(
                                theme.textTheme.headlineLarge?.color ??
                                    Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {},
                            backgroundColor: theme
                                .secondaryHeaderColor, //AppColors.secondaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Email To Card
                email_To_Card(theme, profilePhoto, width),
                SizedBox(height: 16.h),

                //Email From Card
                email_From_Card(theme, profilePhoto, width),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: theme.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            text: "Send Message",
            fontSize: 12.sp,
            icon: Icon(
              Icons.mail_outline_outlined,
              color: theme.secondaryHeaderColor,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: theme.secondaryHeaderColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.9,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    builder: (context, scrollController) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 10.h,
                        ),
                        child: Column(
                          children: [
                            /// Top drag handle
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              width: 50,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),

                            /// Main scrollable content connected to scrollController
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                child: const ComposeEmailScreen(),
                              ),
                            ),
                          ],
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

  //Email to Card
  Container email_To_Card(ThemeData theme, profilePhoto, double width) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2) ??
              AppColors.greyColor.withValues(alpha: 0.2), //AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
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
                // color: AppColors.titleColor,
              ),
              SizedBox(width: 10.w),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: theme.textTheme.bodyLarge?.color?.withValues(
                  alpha: 0.3,
                ), //AppColors.greyColor,,//Colors.grey.shade300,
                backgroundImage: profilePhoto.isNotEmpty
                    ? NetworkImage(profilePhoto)
                    : null,
                child: profilePhoto.isEmpty
                    ? KText(
                        text: "PC",
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.035,
                        color: AppColors.checkInColor,
                      )
                    : null,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: "Pristia Candra",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    //  color: AppColors.titleColor,
                  ),
                  KText(
                    text: "debra.holt@example.com",
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color:
                        theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
                  ),
                ],
              ),
              Spacer(),
              KText(
                text: "Nov12,2:55",
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              ),
              Container(),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2),
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
                //color: AppColors.titleColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: KText(
                  text: "Thank you for your application at Pixel Office",
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  //color: AppColors.titleColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2),
            thickness: 1,
          ),
          SizedBox(height: 16.h),
          // Message body
          KText(
            text: "Hi Cecilia,",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            //color: AppColors.titleColor,
          ),
          SizedBox(height: 12.h),
          KText(
            text:
                "The main duties of a Senior Product Designer include conducting user research and testing, creating wireframes and prototypes, developing design systems, collaborating with cross-functional teams (such as developers, product managers, and other designers),",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            // color: AppColors.titleColor,
            //    height: 1.5,
          ),
        ],
      ),
    );
  }

  //Email From Card
  Container email_From_Card(ThemeData theme, profilePhoto, double width) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2) ??
              AppColors.greyColor.withValues(alpha: 0.2), //AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // To section
          Row(
            children: [
              KText(text: "From", fontWeight: FontWeight.w500, fontSize: 14.sp),
              SizedBox(width: 3.w),

              CircleAvatar(
                radius: 20.r,
                backgroundColor: theme.textTheme.bodyLarge?.color?.withValues(
                  alpha: 0.3,
                ),
                backgroundImage: profilePhoto.isNotEmpty
                    ? NetworkImage(profilePhoto)
                    : null,
                child: profilePhoto.isEmpty
                    ? KText(
                        text: "PC",
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.035,
                        color: AppColors.checkInColor,
                      )
                    : null,
              ),
              SizedBox(width: 3.w),

              // Middle section without Expanded
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: "Pristia Candra",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    KText(
                      text: "debra.holt@example.com",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              /// ⬇️ Push date to the right — always visible
              Spacer(),

              KText(
                text: "Nov 12, 2:55",
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2),
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
                //color: AppColors.titleColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: KText(
                  text: "Thank you for your application at Pixel Office",
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  //color: AppColors.titleColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.2),
            thickness: 1,
          ),
          SizedBox(height: 16.h),
          // Message body
          KText(
            text: "Hi Cecilia,",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            //color: AppColors.titleColor,
          ),
          SizedBox(height: 12.h),
          KText(
            text:
                "The main duties of a Senior Product Designer include conducting user research and testing, creating wireframes and prototypes, developing design systems, collaborating with cross-functional teams (such as developers, product managers, and other designers),",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            // color: AppColors.titleColor,
            //    height: 1.5,
          ),
        ],
      ),
    );
  }
}
