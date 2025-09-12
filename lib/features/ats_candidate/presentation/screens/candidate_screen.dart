import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_app_bar.dart';
import 'package:fuoday/commons/widgets/k_filter_button.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_gradient_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_ats_applicatitem.dart';
import 'package:fuoday/features/home/presentation/widgets/k_calendar.dart';
import 'package:go_router/go_router.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

int get totalPages => (applicantsData.length / itemsPerPage).ceil();

int pageWindowStart = 1; // first page in current window
int pageWindowSize = 5; // show 5 numbers at a time

// Pagination state
int currentPage = 1;
int itemsPerPage = 6; // Change this to show how many items per page

List<Map<String, dynamic>> get paginatedApplicants {
  int totalPages = (applicantsData.length / itemsPerPage).ceil();

  // Ensure currentPage is within range
  if (currentPage > totalPages) currentPage = totalPages;
  if (currentPage < 1) currentPage = 1;

  int startIndex = (currentPage - 1) * itemsPerPage;
  int endIndex = startIndex + itemsPerPage;
  if (startIndex >= applicantsData.length) return []; // safe guard
  if (endIndex > applicantsData.length) endIndex = applicantsData.length;

  return applicantsData.sublist(startIndex, endIndex);
}

List<Map<String, dynamic>> applicantsData = [
  {
    'name': 'Pristia Candra',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '01 May 2025',
    'avatarColor': AppColors.primaryColor,
  },
  {
    'name': 'Hanna Baptista',
    'email': 'hanna@gmail.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '01 May 2025',
    'avatarColor': AppColors.greyColor,
  },
  {
    'name': 'John Doe',
    'email': 'john@gmail.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.approvedColor,
  },
  {
    'name': 'James George',
    'email': 'james@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.unactive,
  },
  {
    'name': 'Miracle Geidt',
    'email': 'miracle@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.titleColor,
  },
  {
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },{
    'name': 'Skylar Herwitz',
    'email': 'skylar@unpixel.com',
    'phone': '08092139441',
    'cv': 'cv.pdf',
    'createdDate': '02 May 2025',
    'avatarColor': AppColors.authBackToLoginColor,
  },
];

class _CandidateScreenState extends State<CandidateScreen> {
  final TextEditingController jobDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";

    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': Icons.person,
        'title': 'Total Applied',
        'numberOfCount': "3,540",
        'growth': "+5.1%",
      },
      {
        'title': 'Shortlisted Candidates',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Hold Candidates',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Rejected Candidates',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
    ];

    return Scaffold(
      appBar: KAtsAppBar(
        title: "Candidates",
        centerTitle: false,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => Navigator.pop(context),
        cachedNetworkImageUrl: profilePhoto,
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
              // ✅ FIX: wrap multiple children
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 155 / 113, // ✅ matches Figma
                  ),
                  itemCount: gridAttendanceData.length,
                  itemBuilder: (context, index) {
                    final item = gridAttendanceData[index];
                    return AtsTotalCountCard(
                      attendanceCount: item['numberOfCount'].toString(),
                      attendanceCardIcon: item['icon'],
                      attendanceDescription: item['title'],
                      attendanceIconColor: AppColors.primaryColor,
                      attendancePercentageColor: AppColors.checkInColor,
                      growthText: item['growth'],
                    );
                  },
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.recruiterBorderGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                  ),
                  padding: EdgeInsets.all(2.w), // border thickness
                  child: Container(
                    padding: EdgeInsets.all(18.47.w),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(6.5.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🔹 Header Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssetsConstants.starIcon,
                              height: 32.h,
                              width: 32.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: "GenAI Integration",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.titleColor,
                                  ),
                                  KText(
                                    text: "Upload the Resume and check",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                KSnackBar.success(context, "Info tapped");
                              },
                              icon: Icon(
                                Icons.info_outline,
                                size: 20.sp,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        /// 🔹 Upload Picker
                        KAtsUploadPickerTile(
                          showOnlyView: context.filePickerProviderWatch
                              .isPicked("resume"),
                          onViewTap: () {
                            final pickedFile = context.filePickerProviderRead.getFile("resume");
                            if (pickedFile == null) return;

                            final filePath = pickedFile.path;
                            final fileName = pickedFile.name.toLowerCase();

                            if (fileName.endsWith('.pdf')) {
                              GoRouter.of(context).pushNamed(
                                AppRouteConstants.pdfPreview,
                                extra: FilePreviewData(
                                  filePath: filePath!,
                                  fileName: fileName,
                                ),
                              );
                            } else if (fileName.endsWith('.png') ||
                                fileName.endsWith('.jpg') ||
                                fileName.endsWith('.jpeg') ||
                                fileName.endsWith('.webp')) {
                              GoRouter.of(context).pushNamed(
                                AppRouteConstants.imagePreview,
                                extra: FilePreviewData(
                                  filePath: filePath!,
                                  fileName: fileName,
                                ),
                              );
                            } else if (fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
                              // Handle Word files - you can either:
                              // Option 1: Show file info/details
                              KSnackBar.success(
                                context,
                                "Word file selected: ${pickedFile.name}",
                              );

                              // Option 2: Open with system default app (if you have url_launcher)
                              // await launchUrl(Uri.file(filePath!));

                              // Option 3: Navigate to a Word preview screen (if you implement one)
                              // GoRouter.of(context).pushNamed(
                              //   AppRouteConstants.wordPreview,
                              //   extra: FilePreviewData(
                              //     filePath: filePath!,
                              //     fileName: fileName,
                              //   ),
                              // );
                            } else {
                              KSnackBar.failure(
                                context,
                                "Unsupported file type",
                              );
                            }
                          },
                          showCancel: context.filePickerProviderWatch.isPicked(
                            "resume",
                          ),
                          onCancelTap: () {
                            context.filePickerProviderRead.removeFile("resume");
                            KSnackBar.success(
                              context,
                              "File removed successfully",
                            );
                          },
                          uploadOnTap: () async {
                            final key = "resume";
                            final filePicker = context.filePickerProviderRead;
                            await filePicker.pickFile(key);

                            final pickedFile = filePicker.getFile(key);
                            if (filePicker.isPicked(key)) {
                              AppLoggerHelper.logInfo(
                                'Picked file: ${pickedFile!.name}',
                              );
                              KSnackBar.success(
                                context,
                                'Picked file: ${pickedFile.name}',
                              );
                            } else {
                              AppLoggerHelper.logError('No file selected.');
                              KSnackBar.failure(context, 'No file selected.');
                            }
                          },
                          uploadPickerTitle: "",
                          uploadPickerIcon:
                              context.filePickerProviderWatch.isPicked("resume")
                              ? Icons.check_circle
                              : Icons.upload,
                          description: context.filePickerProviderWatch.getFile("resume") != null
                              ? "Selected File: ${context.filePickerProviderWatch.getFile("resume")!.name}"
                              : "Browse file to upload\nSupports .pdf, .doc, .docx",
                        ),

                        SizedBox(height: 16.h),

                        /// 🔹 Job Description label
                        Row(
                          children: [
                            KText(
                              text: "Job Description",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.titleColor,
                            ),
                            KText(
                              text: " *",
                              color: Colors.red,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.info_outline,
                              size: 16.sp,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        /// 🔹 Input Field
                        KAuthTextFormField(
                          // label: "",
                          controller: jobDescriptionController,
                          hintText: "Enter Job Description",
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(height: 20.h),

                        // Align(
                        //   alignment: Alignment.center,
                        //   child:
                        //       /// 🔹 CTA Button
                        //   GenerateAIButton(
                        //
                        //         onPressed: () {
                        //           KSnackBar.success(
                        //             context,
                        //             "Fit check with AI tapped",
                        //           );
                        //         },
                        //       ),
                        // ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              KSnackBar.success(
                                context,
                                "Fit check with AI tapped",
                              );
                            },
                            child: Image.asset(
                              AppAssetsConstants.aiFitCheckPng, // update constant to your PNG path
                              height: 90.h,
                              width: 200.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(18.47.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color: AppColors.greyColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: "Candidate List",
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                      KVerticalSpacer(height: 20.h),

                      // Date and Export Row
                      Row(
                        spacing: 20.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Start Date
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.atsHomepageBg,
                                // background
                                borderRadius: BorderRadius.circular(8.r),
                                // rounded corners
                                border: Border.all(
                                  color: Colors.grey.shade300, // border color
                                  width: 1, // border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    // shadow color
                                    blurRadius: 6,
                                    // softness
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // horizontal, vertical shadow offset
                                  ),
                                ],
                              ),
                              child: KAuthFilledBtn(
                                text: "Filter",
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.greyColor,
                                icon: SvgPicture.asset(
                                  AppAssetsConstants.filterIcon,
                                  height: 13.h,
                                  width: 13.w,
                                  fit: BoxFit.contain,
                                ),
                                onPressed: () {
                                  //  selectDate(context, dateController);
                                },
                                backgroundColor: Colors.transparent,
                                // transparent since Container has bg
                                height: 28.h,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),

                          // Export file
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.atsHomepageBg,
                                // background
                                borderRadius: BorderRadius.circular(10.r),
                                // rounded corners
                                border: Border.all(
                                  color: Colors.grey.shade300, // border color
                                  width: 1, // border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(
                                      0.1,
                                    ), // shadow color
                                    blurRadius: 6, // softness
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // horizontal, vertical shadow offset
                                  ),
                                ],
                              ),
                              child: KAuthFilledBtn(
                                text: "Candidate",
                                icon: SvgPicture.asset(
                                  AppAssetsConstants.downloadIcon,
                                  // Replace with your delete SVG
                                  height: 13.67.h,
                                  width: 14.w,
                                  fit: BoxFit.contain,
                                  color: Colors.white, // Optional: tint the SVG
                                ),
                                onPressed: () {},
                                backgroundColor: AppColors.primaryColor,
                                height: 28.h,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   width: 140,
                      //   height: 44,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 18,
                      //     vertical: 10,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFF9258BC), // background: rgba(146, 88, 188, 1)
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(
                      //       color: const Color(0xFF9258BC), // same as bg
                      //       width: 1,
                      //     ),
                      //     boxShadow: [
                      //       // outer glow
                      //       BoxShadow(
                      //         color: const Color(0xFFEBF2FF), // rgba(235, 242, 255, 1)
                      //         spreadRadius: 4,
                      //         blurRadius: 0,
                      //         offset: const Offset(0, 0),
                      //       ),
                      //       // subtle drop shadow
                      //       BoxShadow(
                      //         color: const Color.fromRGBO(0, 11, 33, 0.05),
                      //         spreadRadius: 0,
                      //         blurRadius: 2,
                      //         offset: const Offset(0, 1),
                      //       ),
                      //     ],
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       "Button", // 👉 replace with your label
                      //       style: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      KVerticalSpacer(height: 16.h),

                      // Filter Field
                      // KFilterBtn(
                      //   text: "Filter",
                      //   textColor: Colors.black,
                      //   backgroundColor: Colors.white,
                      //   borderColor: const Color.fromRGBO(233, 234, 236, 1),
                      //   borderRadius: BorderRadius.circular(10.r),
                      //   onPressed: () {
                      //     print("Filter pressed");
                      //   },
                      //   icon: SvgPicture.asset(
                      //     AppAssetsConstants.filterIcon,
                      //     height: 16.h,
                      //     width: 16.w,
                      //     color: Colors.black,
                      //   ),
                      // ),

                      KVerticalSpacer(height: 24.h),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: ApplicantTable(
                      //     applicants: applicantsData, // ✅ just pass your list
                      //     itemsPerPage: 6, // optional
                      //   ),
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            ApplicantItem.buildHeader(),
                            SizedBox(height: 16.h),
                            Column(
                              children: List.generate(paginatedApplicants.length, (index) {
                                final applicant = paginatedApplicants[index];
                                final sno = ((currentPage - 1) * itemsPerPage) + index + 1; // 👈 correct numbering

                                return ApplicantItem(
                                  sno: sno,
                                  name: applicant['name'],
                             //     email: applicant['email'], // 👈 if null → won’t show
                                  phoneNumber: applicant['phone'],
                                  cv: applicant['cv'],
                                  createdDate: applicant['createdDate'],
                                  avatarColor: applicant['avatarColor'],
                                  showInitials: true,
                                  initials: applicant['name'].substring(0, 2).toUpperCase(),
                                  showAvatar: false, // 👈 if you don’t want avatar
                                  onStageChanged: (newStage) {
                                    print("${applicant['name']} stage changed to $newStage");
                                  },
                                );

                              }),

                            ),
                          ],
                        ),
                      ),


                      KVerticalSpacer(height: 24.h),

                      // Pagination
                      _buildPageNumbersRow(),

                      SizedBox(height: 16.w),
                      Row(
                        children: [
                          KText(
                            text: "Showing 1 to 8 of 50 entries",
                            fontSize: 12.sp,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 40.w),
                          Container(
                            padding: EdgeInsets.all(10.w),
                            // ✅ Padding from Figma
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.77.w, // ✅ Border width
                                color: AppColors.greyColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              // ✅ Border radius
                              color: AppColors.secondaryColor,
                            ),
                            child: Row(
                              children: [
                                KText(
                                  text: "Show 8",
                                  fontSize: 12.sp,
                                  color: AppColors.titleColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                Icon(Icons.keyboard_arrow_up, size: 14.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.w),

                Container(
                  padding: EdgeInsets.all(18.47.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color: AppColors.greyColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      CalendarHeader(),

                      SizedBox(height: 20.h),

                      // TODAY Section
                      TodaySection(),

                      SizedBox(height: 24.h),

                      // UPCOMING Section
                      UpcomingSection(),
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

  Widget _buildPageNumbersRow() {
    int windowEnd = (pageWindowStart + pageWindowSize - 1);
    if (windowEnd > totalPages) windowEnd = totalPages;

    List<Widget> pageButtons = [];

    // Previous window arrow
    pageButtons.add(
      IconButton(
        icon: Icon(Icons.chevron_left, size: 16.sp),
        onPressed: pageWindowStart > 1
            ? () {
                setState(() {
                  pageWindowStart -= pageWindowSize;
                  currentPage = pageWindowStart;
                });
              }
            : null,
      ),
    );

    // Page numbers
    for (int i = pageWindowStart; i <= windowEnd; i++) {
      pageButtons.add(
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: _buildPageNumber(i),
        ),
      );
    }

    // Next window arrow
    pageButtons.add(
      IconButton(
        icon: Icon(Icons.chevron_right, size: 16.sp),
        onPressed: windowEnd < totalPages
            ? () {
                setState(() {
                  pageWindowStart += pageWindowSize;
                  currentPage = pageWindowStart;
                });
              }
            : null,
      ),
    );

    return Row(children: pageButtons);
  }

  Widget _buildPageNumber(int pageNum) {
    final isActive = pageNum == currentPage;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = pageNum;
        });
      },
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFF8F8F8) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: KText(
            text: pageNum.toString(),
            fontSize: 12.sp,
            color: isActive ? Colors.black : AppColors.titleColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
