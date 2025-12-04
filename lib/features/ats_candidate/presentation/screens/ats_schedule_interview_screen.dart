import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';

import 'ats_candidate_information_screen.dart';

class ScheduleInterviewScreen extends StatefulWidget {
  const ScheduleInterviewScreen({super.key});

  @override
  State<ScheduleInterviewScreen> createState() =>
      _ScheduleInterviewScreenState();
}

class _ScheduleInterviewScreenState extends State<ScheduleInterviewScreen> {
  // Dropdown selected values
  String? interviewStage;
  String? interviewType;
  String? interviewLocation;
  String? interviewer;
  String? template;

  // Date & Time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Controllers for KAuthTextFormField
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: KText(
          text: "Schedule Interview",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interview Stage
            const KTitleText(title: "Interview Stage"),
            KVerticalSpacer(height: 6.h),
            KDropdownTextFormField<String>(
              hintText: "Select Interview Stage",
              items: ["Screening", "Technical", "HR", "Final"],
              value: interviewStage,
              onChanged: (v) => setState(() => interviewStage = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select stage" : null,
            ),
            KVerticalSpacer(height: 16.h),

            // Interview Type
            const KTitleText(title: "Interview Type"),
            KVerticalSpacer(height: 6.h),
            KDropdownTextFormField<String>(
              hintText: "Select Interview Type",
              items: ["Online", "Offline", "Telephonic"],
              value: interviewType,
              onChanged: (v) => setState(() => interviewType = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select type" : null,
            ),
            KVerticalSpacer(height: 16.h),

            // Interview Date & Time (centered using KAuthTextFormField)
            const KTitleText(title: "Interview Date & Time"),
            KVerticalSpacer(height: 6.h),
            Row(
              children: [
                // Date picker
                Expanded(
                  child: KAuthTextFormField(
                    controller: dateController,
                    label: "Date",
                    hintText: "Select Date",
                    isReadOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                          dateController.text =
                              "${date.day}/${date.month}/${date.year}";
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                // Time picker
                Expanded(
                  child: KAuthTextFormField(
                    controller: timeController,
                    label: "Time",
                    hintText: "Select Time",
                    isReadOnly: true,
                    onTap: () async {
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          selectedTime = time;
                          timeController.text = time.format(context);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            KVerticalSpacer(height: 16.h),

            // Interview Location
            const KTitleText(title: "Interview Location"),
            KVerticalSpacer(height: 6.h),
            KDropdownTextFormField<String>(
              hintText: "Select Location",
              items: ["Bangalore", "Hyderabad", "Chennai", "Remote"],
              value: interviewLocation,
              onChanged: (v) => setState(() => interviewLocation = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select location" : null,
            ),
            KVerticalSpacer(height: 16.h),

            // Interviewers
            const KTitleText(title: "Interviewers"),
            KVerticalSpacer(height: 6.h),
            KDropdownTextFormField<String>(
              hintText: "Select Interviewer",
              items: ["Alice", "Bob", "Charlie", "David"],
              value: interviewer,
              onChanged: (v) => setState(() => interviewer = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select interviewer" : null,
            ),
            KVerticalSpacer(height: 16.h),
            KTitleText(title: "Template"),
            KVerticalSpacer(height: 6.h),
            KDropdownTextFormField<String>(
              hintText: "Select Template",
              items: [
                "Default Template",
                "Reminder Template",
                "Offer Template",
                "Follow-up Template",
              ],
              value: template,
              onChanged: (v) => setState(() => template = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select template" : null,
            ),
            KVerticalSpacer(height: 16.h),

            MailPreviewCard(
              receiverName: "Pristia Candra",
              subject: "Thank you for your application at Pixel Office",
              message: """
Hi Cecilia,

The main duties of a Senior Product Designer include conducting user research and testing, creating wireframes and prototypes, developing design systems, collaborating with cross-functional teams (such as developers, product managers, and other designers), and presenting design solutions to stakeholders.
""",
              date: "Nov12,2.55",
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
            backgroundColor: theme.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
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
            text: "Add Interview",
            fontSize: 12.sp,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class MailPreviewCard extends StatelessWidget {
  final String receiverName;
  final String subject;
  final String message;
  final String date;

  const MailPreviewCard({
    super.key,
    required this.receiverName,
    required this.subject,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
          style: BorderStyle.solid, // if want dashed use dotted_border package
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // To Row
          Padding(
            padding: EdgeInsets.all(18.w),
            child: Row(
              children: [
                Text(
                  "To",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(width: 10.w),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.textTheme.bodyLarge?.color?.withValues(
                      alpha: 0.1,
                    ), //AppColors.greyColor,,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/jpg/person-placeholder-img.jpeg",
                            ), //person-placeholder-img.jpeg
                          ),
                        ),
                      ),

                      SizedBox(width: 8.w),
                      Text(
                        receiverName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),

          // SizedBox(height: 18.h),
          Divider(
            height: 1,
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
          ),

          // Subject
          Padding(
            padding: EdgeInsets.all(18.w),
            child: RichText(
              text: TextSpan(
                text: "Subject :  ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.headlineLarge?.color,
                  fontSize: 14.sp,
                ),
                children: [
                  TextSpan(
                    text: subject,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(
            height: 1,
            color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3),
          ),

          // Message Body
          Padding(
            padding: EdgeInsets.all(18.w),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: theme
                    .textTheme
                    .headlineLarge
                    ?.color, //AppColors.titleColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
