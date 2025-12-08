import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CandidateApplicationViewScreen extends StatefulWidget {
  const CandidateApplicationViewScreen({super.key});

  @override
  State<CandidateApplicationViewScreen> createState() =>
      _CandidateApplicationViewScreenState();
}

class _CandidateApplicationViewScreenState
    extends State<CandidateApplicationViewScreen> {
  bool isEditable = false; // 👈 edit toggle

  // Controllers
  final nameController = TextEditingController(text: "Mohamed Irfan");
  final jobIdController = TextEditingController(text: "JOB10235");
  final dateController = TextEditingController(text: "08-12-2025");
  final jobTitleController = TextEditingController(
    text: "Senior Flutter Developer",
  );
  final totalExpController = TextEditingController(text: "5 Years");
  final relevantExpController = TextEditingController(text: "3 Years");
  final organizationController = TextEditingController(
    text: "ABC Technologies",
  );
  final orgTypeController = TextEditingController(text: "IT Services");
  final currentLocationController = TextEditingController(text: "Bangalore");
  final preferredLocationController = TextEditingController(text: "Chennai");
  final noticePeriodController = TextEditingController(text: "30 Days");
  final offerInHandController = TextEditingController(text: "1 Offer");
  final lastCtcController = TextEditingController(text: "6 LPA");
  final expectedCtcController = TextEditingController(text: "9 LPA");
  final educationController = TextEditingController(text: "B.E CSE");
  final recruiterController = TextEditingController(text: "John Michael");
  final acknowledgementController = TextEditingController(text: "Yes");
  final dispositionController = TextEditingController(text: "Reviewed");
  final processController = TextEditingController(text: "Technical Screening");
  final emailStatusController = TextEditingController(text: "Sent");
  final candidateStatusController = TextEditingController(text: "In Process");
  final dvByController = TextEditingController(text: "Priya");
  final interviewDateController = TextEditingController(text: "15-12-2025");
  final interviewStatusController = TextEditingController(text: "Selected");
  final recruiterScoreController = TextEditingController(text: "8/10");
  final feedbackController = TextEditingController(
    text: "Excellent communication & Flutter knowledge",
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Candidates",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            KText(
              text: "Manage your Candidates",
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: theme.textTheme.bodyLarge?.color,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // USER CARD --- (Not modified)
              _buildUserCard(theme),

              SizedBox(height: 16.h),

              //  Candidate Details (with edit enable)
              _candidate_detailsrd(theme, context),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.77.w,
                    color:
                        theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.3,
                        ) ??
                        AppColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(7.69.r),
                  color: theme.secondaryHeaderColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: KText(
                          text: "ATS Score",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: KText(
                          text:
                              "We analyzed how well the resume matches the Role.Here's what we found:",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ScoreGauge(score: 90, status: "Good"),
                      KText(
                        text: "Candidate Resume Scored Good",
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              AiResumeFitCheckCard(),
            ],
          ),
        ),
      ),
    );
  }

  Container _candidate_detailsrd(ThemeData theme, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.77.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(7.69.r),
        color: theme.secondaryHeaderColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Edit icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KText(
                  text: "Candidate Details",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  icon: Icon(
                    isEditable ? Icons.check_circle : Icons.edit,
                    color: theme.textTheme.bodyLarge?.color?.withValues(
                      alpha: 0.7,
                    ),
                    size: 22,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // 🔽 ALL TEXTFIELDS (ReadOnly until edit pressed)
            KAuthTextFormField(
              label: "Candidate Name",
              controller: nameController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Job ID",
              controller: jobIdController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Date",
              controller: dateController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Job Title",
              controller: jobTitleController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Total Experience",
              controller: totalExpController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Relevant Experience",
              controller: relevantExpController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Present Organization",
              controller: organizationController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Organization Type",
              controller: orgTypeController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Current Location",
              controller: currentLocationController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Preferred Location",
              controller: preferredLocationController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Notice Period",
              controller: noticePeriodController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Offer in Hand",
              controller: offerInHandController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Last CTC",
              controller: lastCtcController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Expected CTC",
              controller: expectedCtcController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Education",
              controller: educationController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Recruiter Name",
              controller: recruiterController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Acknowledgement",
              controller: acknowledgementController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Disposition",
              controller: dispositionController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Process",
              controller: processController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Email Status",
              controller: emailStatusController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Candidate Status",
              controller: candidateStatusController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "DV By",
              controller: dvByController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Interview Date",
              controller: interviewDateController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Interview Status",
              controller: interviewStatusController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Recruiter Score",
              controller: recruiterScoreController,
              isReadOnly: !isEditable,
            ),
            SizedBox(height: 12.h),
            KAuthTextFormField(
              label: "Feedback",
              controller: feedbackController,
              isReadOnly: !isEditable,
            ),

            SizedBox(height: 20.h),

            if (isEditable)
              Center(
                child: KAtsGlowButton(
                  width: 240.w,
                  text: "Save",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  gradientColors: AppColors.atsButtonGradientColor,
                  textColor: theme.secondaryHeaderColor,
                  onPressed: () {
                    setState(() => isEditable = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Saved Successfully")),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 🔹 Your original user profile card
  Widget _buildUserCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.77.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(7.69.r),
        color: theme.secondaryHeaderColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35.r,
              backgroundColor: AppColors.checkInColor.withValues(alpha: 0.3),
              child: KText(
                text: "MI",
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: AppColors.checkInColor,
              ),
            ),
            SizedBox(height: 5.w),
            KText(
              text: "Mohamed Irfan",
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            SizedBox(height: 5.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: theme.textTheme.bodyLarge?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
                SizedBox(width: 5.w),
                KText(
                  text: "+91 73958 66830",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ],
            ),
            SizedBox(height: 5.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: theme.textTheme.bodyLarge?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
                SizedBox(width: 5.w),
                KText(
                  text: "mohamedirfan@gmail.com",
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AiResumeFitCheckCard extends StatelessWidget {
  const AiResumeFitCheckCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(2.w), // Border thickness
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.recruiterBorderGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          //BORDER COLOR
          color: theme.secondaryHeaderColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssetsConstants.starIcon,
                    height: 32.h,
                    width: 32.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8.w),
                  KText(
                    text: "Ai Resume Fit Check",

                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            SizedBox(height: 18.h),

            // 🔹 Decision
            _buildBlock(title: "Decision", value: "Fit", theme: theme),

            SizedBox(height: 18.h),

            // 🔹 Explanation
            _buildBlock(
              title: "Explanation",
              value:
                  "He has experience working with Python, Keras, Tensorflow, and ARIMA algorithms. He has also showcased his ability to apply these skills to real-world projects such as TATA COFFEE NSE Price Prediction, Fake News Detection, and Helmet Detection.",
              theme: theme,
            ),

            SizedBox(height: 18.h),

            // 🔹 Suggested Roles
            _buildBlock(
              title: "Suggested Roles",
              value: "Front End Developer",
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock({
    required String title,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          width: 1.2.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.4) ??
              AppColors.greyColor,
        ), //BORDER COLOR
        color: theme.textTheme.bodyLarge?.color?.withValues(
          alpha: 0.04,
        ), //AppColors.greyColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            text: title,

            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
          ),
          SizedBox(height: 8.h),
          KText(text: value, fontSize: 13.sp, fontWeight: FontWeight.w400),
        ],
      ),
    );
  }
}

class ReusableRadialGauge extends StatelessWidget {
  final double min;
  final double max;
  final double value;
  final List<GaugeRange> ranges;
  final String? title;
  final TextStyle? titleStyle;

  const ReusableRadialGauge({
    super.key,
    this.min = 0,
    this.max = 150,
    required this.value,
    required this.ranges,
    this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title: title != null
          ? GaugeTitle(
              text: title!,
              textStyle:
                  titleStyle ??
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          : null,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: min,
          maximum: max,
          ranges: ranges,
          pointers: <GaugePointer>[NeedlePointer(value: value)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}

class ScoreGauge extends StatelessWidget {
  final double score; // example: 90
  final String status; // example: Good

  const ScoreGauge({super.key, required this.score, required this.status});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradientColors = isDark
        ? [
            Color(0xffFF5722), // darker red for dark theme
            Color(0xffffc107), // amber/yellow
            Color(0xff8bc34a), // light green
          ]
        : [
            Color(0xffFF3D00), // red
            Color(0xffFFB300), // yellow
            Color(0xff64DD17), // green
          ];
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: 140,
          endAngle: 40,
          radiusFactor: 0.9,
          minimum: 0,
          maximum: 100,

          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 100,
              startWidth: 25,
              endWidth: 25,
              gradient: SweepGradient(
                colors: gradientColors,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ],

          pointers: [
            NeedlePointer(
              value: score,
              enableAnimation: true,
              needleColor:
                  theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
              tailStyle: TailStyle(
                width: 6,
                length: 0.17,
                color: theme.textTheme.headlineLarge?.color,
              ),
            ),
          ],

          annotations: [
            // Center circle with score
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0,
              widget: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: theme.secondaryHeaderColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      color:
                          theme.textTheme.headlineLarge?.color?.withValues(
                            alpha: 0.1,
                          ) ??
                          Colors.black.withValues(alpha: 0.1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KText(
                      text: "Scored",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    KText(
                      text: score.toStringAsFixed(0),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: score >= 70
                            ? Colors.green
                            : (score >= 40 ? Colors.orange : Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Start rounded circle
            /*  GaugeAnnotation(
              angle: 140,
              positionFactor: 0.9,
              widget: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Color(0xffFF3D00),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // End rounded circle
            GaugeAnnotation(
              angle: 40,
              positionFactor: 0.9,
              widget: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Color(0xff64DD17),
                  shape: BoxShape.circle,
                ),
              ),
            ),*/
          ],
        ),
      ],
    );
  }
}
