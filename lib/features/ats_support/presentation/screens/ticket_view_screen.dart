import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/gmail_compose_index.dart';
import 'package:fuoday/features/ats_support/presentation/widgets/add_response_dialog.dart';
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
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    return Scaffold(
      backgroundColor: theme.cardColor, //ATS Background Color
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Support Center",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: theme
                    .textTheme
                    .headlineLarge
                    ?.color, //AppColors.titleColor,
              ),
            ),
            Text(
              "Manage Tickets",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        /*actions: [
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
              backgroundColor: theme.textTheme.bodyLarge?.color?.withValues(
                alpha: 0.3,
              ), //AppColors.greyColor,,
              child: Icon(Icons.person, size: 20),
            ),
          ),
        ],*/
        backgroundColor: theme.secondaryHeaderColor, //AppColors.secondaryColor,
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
                color: theme
                    .textTheme
                    .headlineLarge
                    ?.color, //AppColors.titleColor,
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
            //Ticket Issue Container
            Container(
              // width: 343.w,
              height: isTablet ? (isLandscape ? 255.h : 248.h) : 200.h,
              decoration: BoxDecoration(
                color: theme.secondaryHeaderColor, //AppColors.secondaryColor
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color:
                      theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ) ??
                      AppColors.greyColor,
                  width: 1.w,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: "Ticket Issue",
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color, //AppColors.titleColor,
                    ),
                    KVerticalSpacer(height: 16.h),
                    KText(
                      text:
                          "Hi, I can’t seem to update the app. It says “Error checking updates” when I tried to update the app via Google Play. Pls help.",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                    KVerticalSpacer(height: 16.h),
                    KImageContainer(),
                  ],
                ),
              ),
            ),
            KVerticalSpacer(height: 16.h),

            Container(
              width: 343.w,
              height: isTablet ? (isLandscape ? 280.h : 248.h) : 248.h,
              decoration: BoxDecoration(
                color: isDark ? AppColors.chatBgDark : AppColors.chatBg,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color:
                      theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ) ??
                      AppColors.greyColor,
                  width: 1.w,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.headset_mic_outlined, color: Colors.blue),
                        SizedBox(width: 20),
                        KText(
                          text: "Deanna Jones",
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          // color: AppColors.atsTittleText,
                        ),
                      ],
                    ),
                    KVerticalSpacer(height: 24.h),
                    KText(
                      text:
                          "Have you tried turning your phone off and on again?",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      //color: AppColors.atsTittleText,
                    ),
                    KVerticalSpacer(height: 50.h),
                    KImageContainer(),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: KText(
                        text: "20:00",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: theme
                            .textTheme
                            .bodyLarge
                            ?.color, //AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            KVerticalSpacer(height: 16.h),

            Container(
              width: 343.w,
              height: isTablet ? (isLandscape ? 255.h : 248.h) : 248.h,
              decoration: BoxDecoration(
                color: theme.secondaryHeaderColor, //AppColors.secondaryColor
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color:
                      theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ) ??
                      AppColors.greyColor,
                  width: 1.w,
                ),
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
                      color: theme
                          .textTheme
                          .headlineLarge
                          ?.color, //AppColors.titleColor,
                    ),
                    KVerticalSpacer(height: 24.h),
                    KText(
                      text:
                          "Why can’t I update the app? It keeps reloading the same page. Please help.",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                    KVerticalSpacer(height: 50.h),
                    KImageContainer(),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: KText(
                        text: "20:00",
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: theme
                            .textTheme
                            .bodyLarge
                            ?.color, //AppColors.greyColor,
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
          child: KAtsGlowButton(
            //height: AppResponsive.responsiveBtnHeight(context),
            text: "Add Response",
            fontWeight: FontWeight.w600,
            fontSize: 13,
            icon: SvgPicture.asset(
              AppAssetsConstants.addIcon,
              height: 16,
              width: 16,
              fit: BoxFit.contain,
              //SVG IMAGE COLOR
              colorFilter: ColorFilter.mode(
                theme.secondaryHeaderColor,
                BlendMode.srcIn,
              ),
            ),
            textColor: theme.secondaryHeaderColor,
            gradientColors: AppColors.atsButtonGradientColor,
            // backgroundColor: theme.secondaryHeaderColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddResponseDialogWidget(
                  title: "Add Response",
                  responseLabel: "Response",
                  uploadLabel: "Upload Image",
                  fileKey: "AllTicketAddResponseImage",
                  onSendTap: (responseText, pickedFile) {
                    print("Response: $responseText");
                    print("File: ${pickedFile?.name}");
                  },
                ),
              );
            },
          ),

          // KAuthFilledBtn(
          //   backgroundColor: theme.primaryColor,
          //   height: AppResponsive.responsiveBtnHeight(context),
          //   width: double.infinity,
          //  icon:
          //   text: "Add Response",
          //   fontSize: 12.sp,
          //   onPressed: () {
          //
          //   },
          // ),
        ),
      ),
    );
  }
}

//Bottom Image Widget
class KImageContainer extends StatelessWidget {
  final String? imagePath; // asset image path (nullable)
  final double width;
  final double height;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final IconData placeholderIcon; // <-- ICON placeholder

  const KImageContainer({
    super.key,
    this.imagePath,
    this.width = 70,
    this.height = 60,
    this.radius = 10,
    this.backgroundColor,
    this.borderColor,
    this.placeholderIcon = Icons.image, // default icon
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final effectiveBorderColor =
        borderColor ?? theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.1);

    final effectiveBackground =
        backgroundColor ??
        theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.08);

    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(
          color: effectiveBorderColor ?? Colors.grey,
          width: 1.w,
        ),
        image: hasImage
            ? DecorationImage(image: AssetImage(imagePath!), fit: BoxFit.cover)
            : null,
      ),
      child: !hasImage
          ? Center(
              child: Icon(
                placeholderIcon,
                size: 20.sp,
                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
              ),
            )
          : null,
    );
  }
}
