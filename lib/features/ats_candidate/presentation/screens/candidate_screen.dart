import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
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
import 'package:fuoday/features/ats_candidate/presentation/provider/candidates_provider.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/draft_provider.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_candidates_datatable.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CandidateScreen extends StatefulWidget {
  const CandidateScreen({super.key});

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final searchController = TextEditingController();

  final String currentRoute =
      AppRouteConstants.atsCandidate; // Replace with actual current route

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _fetchCandidates();
    // });
  }

  Future<void> downloadPdfFromUrl(String url) async {
    try {
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode != 200) {
        throw Exception("File not found");
      }

      final bytes = await consolidateHttpClientResponseBytes(response);

      final directory = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final file = File("${directory.path}/$fileName");

      await file.writeAsBytes(bytes);

      await OpenFilex.open(file.path);
    } catch (e) {
      debugPrint("Download error: $e");
    }
  }

  void _fetchCandidates() {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserId = employeeDetails?['web_user_id']?.toString() ?? '';

    context.read<CandidatesProvider>().fetchCandidates(webUserId);
  }

  /*  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows(List<CandidateEntity> candidates) {
    return candidates.asMap().entries.map((entry) {
      int index = entry.key;
      var data = entry.value;
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'SNo', value: index + 1),
          DataGridCell<String>(columnName: 'Name', value: data.candidateName),
          DataGridCell<String>(
            columnName: 'mobileNumber',
            value: data.mobileNumber,
          ),
          DataGridCell<String>(columnName: 'CV', value: data.resume),
          DataGridCell<String>(
            columnName: 'Experience',
            value: data.totalExperience,
          ),
          DataGridCell<String>(columnName: 'Email', value: data.email),
          DataGridCell<String>(columnName: 'Status', value: data.disposition),
          DataGridCell<String>(
            columnName: 'Recruiter',
            value: data.recruiterName,
          ),
          DataGridCell<String>(columnName: 'Action', value: "action"),
        ],
      );
    }).toList();
  }*/

  String selectedFilter = "All Status";
  String searchQuery = "";

  @override
  void dispose() {
    jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    final draftProvider = context.watch<DraftProvider>();
    final draftList = draftProvider.draftList.length;

    return Consumer<CandidatesProvider>(
      builder: (context, candidatesProvider, child) {
        // Update grid data with counts
        final List<Map<String, dynamic>> gridAttendanceData = [
          {
            'icon': AppAssetsConstants.bookIcon,
            'title': 'Total Applied',
            'numberOfCount':
                candidatesProvider.counts?.applied.toString() ?? "0",
            'growth': "+5.1%",
          },
          {
            'title': 'Shortlisted Candidates',
            'numberOfCount':
                candidatesProvider.counts?.shortlisted.toString() ?? "0",
            'growth': "+5.1%",
            'icon': AppAssetsConstants.selectedIcon,
          },
          {
            'title': 'Hold Candidates',
            'numberOfCount':
                candidatesProvider.counts?.holded.toString() ?? "0",
            'growth': "+5.1%",
            'icon': AppAssetsConstants.holdIcon,
          },
          {
            'title': 'Rejected Candidates',
            'numberOfCount':
                candidatesProvider.counts?.rejected.toString() ?? "0",
            'growth': "+5.1%",
            'icon': AppAssetsConstants.rejectedIcon,
          },
        ];

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (!didPop) {
              if (currentRoute != AppRouteConstants.homeRecruiter) {
                context.goNamed(AppRouteConstants.homeRecruiter);
              } else {
                Navigator.of(context).maybePop();
              }
            }
          },
          child: Scaffold(
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
              currentRoute: currentRoute,
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: theme.cardColor, //ATS Background Color
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: RefreshIndicator(
                  // ✅ Add RefreshIndicator here
                  onRefresh: () async {
                    _fetchCandidates();
                    // Wait a bit for the fetch to complete
                    await Future.delayed(Duration(milliseconds: 500));
                  },
                  color: theme.primaryColor,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: "Candidates",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  //  color: AppColors.titleColor,
                                ),

                                KText(
                                  text: "Manage your Candidates",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: theme
                                      .textTheme
                                      .bodyLarge
                                      ?.color, //AppColors.greyColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            KAtsGlowButton(
                              text: "Candidates",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              textColor: theme.secondaryHeaderColor,
                              gradientColors: AppColors.atsButtonGradientColor,
                              icon: SvgPicture.asset(
                                AppAssetsConstants.addIcon,
                                height: 15,
                                width: 15,
                                fit: BoxFit.contain,
                                //SVG IMAGE COLOR
                                colorFilter: ColorFilter.mode(
                                  theme.secondaryHeaderColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {
                                print("Candidates button tapped");
                                GoRouter.of(context).pushNamed(
                                  AppRouteConstants
                                      .atsCandidateInformationScreen,
                                );
                              },
                              backgroundColor: theme.primaryColor,
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Grid Cards with counts
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                childAspectRatio: 155 / 113,
                              ),
                          itemCount: gridAttendanceData.length,
                          itemBuilder: (context, index) {
                            final item = gridAttendanceData[index];
                            return AtsTotalCountCard(
                              employeeCount: item['numberOfCount'].toString(),
                              employeeCardIcon: item['icon'],
                              employeeDescription: item['title'],
                              employeeIconColor: theme.primaryColor,
                              employeePercentageColor: isDark
                                  ? AppColors.checkInColorDark
                                  : AppColors.checkInColor,
                              growthText: item['growth'],
                            );
                          },
                        ),

                        SizedBox(height: 16.h),

                        // GenAI Integration section (keep existing code)
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
                              color: theme
                                  .secondaryHeaderColor, //AppColors.secondaryColor
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: "GenAI Integration",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            //color: AppColors.titleColor,
                                          ),
                                          KText(
                                            text: "Upload the Resume and check",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: theme
                                                .textTheme
                                                .bodyLarge
                                                ?.color, //AppColors.greyColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        KSnackBar.success(
                                          context,
                                          "Info tapped",
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 20.sp,
                                        color: theme
                                            .textTheme
                                            .bodyLarge
                                            ?.color, //AppColors.greyColor,
                                      ),
                                    ),
                                  ],
                                ),

                                // SizedBox(height: 16.h),

                                /// 🔹 Upload Picker
                                KAtsUploadPickerTile(
                                  backgroundcolor:
                                      theme.cardColor, //ATS Background Color
                                  showOnlyView: context.filePickerProviderWatch
                                      .isPicked("resume"),
                                  onViewTap: () {
                                    final pickedFile = context
                                        .filePickerProviderRead
                                        .getFile("resume");
                                    if (pickedFile == null) return;

                                    final filePath = pickedFile.path;
                                    final fileName = pickedFile.name
                                        .toLowerCase();

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
                                    } else if (fileName.endsWith('.doc') ||
                                        fileName.endsWith('.docx')) {
                                      KSnackBar.success(
                                        context,
                                        "Word file selected: ${pickedFile.name}",
                                      );
                                    } else {
                                      KSnackBar.failure(
                                        context,
                                        "Unsupported file type",
                                      );
                                    }
                                  },
                                  showCancel: context.filePickerProviderWatch
                                      .isPicked("resume"),
                                  onCancelTap: () {
                                    context.filePickerProviderRead.removeFile(
                                      "resume",
                                    );
                                    KSnackBar.success(
                                      context,
                                      "File removed successfully",
                                    );
                                  },
                                  uploadOnTap: () async {
                                    final key = "resume";
                                    final filePicker =
                                        context.filePickerProviderRead;
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
                                      AppLoggerHelper.logError(
                                        'No file selected.',
                                      );
                                      KSnackBar.failure(
                                        context,
                                        'No file selected.',
                                      );
                                    }
                                  },
                                  uploadPickerTitle: "",
                                  uploadPickerIcon:
                                      context.filePickerProviderWatch.isPicked(
                                        "resume",
                                      )
                                      ? Icons.check_circle
                                      : Icons.upload,
                                  description:
                                      context.filePickerProviderWatch.getFile(
                                            "resume",
                                          ) !=
                                          null
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
                                      // color: AppColors.titleColor,
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
                                      color: theme
                                          .textTheme
                                          .bodyLarge
                                          ?.color, //AppColors.greyColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),

                                /// 🔹 Input Field
                                KAuthTextFormField(
                                  controller: jobDescriptionController,
                                  hintText: "Enter Job Description",
                                  keyboardType: TextInputType.text,
                                ),

                                SizedBox(height: 16.h),

                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      KSnackBar.success(
                                        context,
                                        "Fit check with AI tapped",
                                      );
                                      GoRouter.of(context).pushNamed(
                                        AppRouteConstants
                                            .atsCandidateApplicationViewScreen,
                                      );
                                    },
                                    child: Image.asset(
                                      AppAssetsConstants.aiFitCheckPng,
                                      height: 90.h,
                                      width: 200.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 14.h),

                        // Candidate List Table
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.77.w,
                              color:
                                  theme.textTheme.bodyLarge?.color?.withValues(
                                    alpha: 0.3,
                                  ) ??
                                  AppColors.greyColor, //BORDER COLOR
                            ),
                            borderRadius: BorderRadius.circular(7.69.r),
                            color: theme
                                .secondaryHeaderColor, //AppColors.secondaryColor
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                  left: 18.47.w,
                                  right: 18.47.w,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          //flex: 2,
                                          child: KText(
                                            text: selectedFilter,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            // color: AppColors.titleColor,
                                          ),
                                        ),
                                        Expanded(
                                          //flex: 1,
                                          child: KAtsGlowButton(
                                            //  width: ,
                                            text: "Interview",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            textColor:
                                                theme.secondaryHeaderColor,
                                            gradientColors: AppColors
                                                .atsButtonGradientColor,
                                            icon: SvgPicture.asset(
                                              AppAssetsConstants.addIcon,
                                              height: 15,
                                              width: 15,
                                              fit: BoxFit.contain,
                                              //SVG IMAGE COLOR
                                              colorFilter: ColorFilter.mode(
                                                theme.secondaryHeaderColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            onPressed: () {
                                              print("Candidates button tapped");
                                              GoRouter.of(context).pushNamed(
                                                AppRouteConstants
                                                    .atsScheduleInterviewScreen,
                                              );
                                            },
                                            backgroundColor: theme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    KVerticalSpacer(height: 16.h),
                                    KDropdownTextFormField<String>(
                                      hintText: "All Status",
                                      value: context.dropDownProviderWatch
                                          .getValue('priority'),
                                      items: [
                                        'All Status',
                                        'Shortlisted Candidates',
                                        'Holed  Candidates',
                                        'Rejected Candidates',
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedFilter = value!;
                                        });
                                      },
                                    ),
                                    KVerticalSpacer(height: 16.h),
                                    KAtsGlowSearchField(
                                      controller: searchController,
                                      hintText: "Search what you need",
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color:
                                            theme.textTheme.bodyLarge?.color ??
                                            AppColors.greyColor,
                                      ),

                                      backgroundColor:
                                          theme.secondaryHeaderColor,
                                      textColor:
                                          theme
                                              .textTheme
                                              .headlineLarge
                                              ?.color ??
                                          AppColors
                                              .titleColor, //AppColors.titleColor,,
                                      onChanged: (value) {
                                        print("Typing: $value");
                                      },
                                      onSubmitted: (value) {
                                        print("Search submitted: $value");
                                      },
                                    ),

                                    KVerticalSpacer(height: 16.h),
                                    Row(
                                      spacing: 20.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: KAtsGlowButton(
                                            text: "Filter",
                                            textColor:
                                                theme
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color ??
                                                AppColors
                                                    .greyColor, //AppColors.greyColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            icon: Icon(
                                              Icons.filter_alt_outlined,
                                              color:
                                                  theme
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.color ??
                                                  AppColors
                                                      .greyColor, //AppColors.titleColor,,
                                            ),
                                            onPressed: () {
                                              print("Filter button tapped");
                                            },
                                            backgroundColor: theme
                                                .secondaryHeaderColor, //AppColors.secondaryColor AppColors.secondaryColor,
                                          ),
                                        ),
                                        // All Status DropDown
                                        Expanded(
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              KAtsGlowButton(
                                                text: "Draft",
                                                textColor:
                                                    theme
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.color ??
                                                    AppColors.greyColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                onPressed: () {
                                                  GoRouter.of(
                                                    context,
                                                  ).pushNamed(
                                                    AppRouteConstants
                                                        .atsDraftScreen,
                                                  );
                                                  print("Draft button tapped");
                                                },
                                                backgroundColor:
                                                    theme.secondaryHeaderColor,
                                              ),
                                              // Badge
                                              Positioned(
                                                top: -14, // adjust as needed
                                                right: -1, // adjust as needed
                                                child: Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: theme
                                                          .cardColor, // optional: border to blend with background
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    draftList
                                                        .toString(), // your badge count
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    KVerticalSpacer(height: 16.h),
                                  ],
                                ),
                              ),

                              // Handle different states

                              // Table renderer
                              if (selectedFilter == "All Status")
                                AllStatusListedTable(searchQuery: searchQuery),
                              if (selectedFilter == "Shortlisted Candidates")
                                ShortlistedTable(),
                              if (selectedFilter == "Holed  Candidates")
                                HoledTable(),
                              if (selectedFilter == "Rejected Candidates")
                                RejectedTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /* Color _getStatusColor(String? status) {
    if (status == null) return AppColors.greyColor;

    switch (status.toLowerCase()) {
      case 'selected':
        return AppColors.checkInColor;
      case 'rejected':
        return AppColors.softRed;
      case 'on hold':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'hr round':
        return Colors.purple;
      default:
        if (status.contains('%')) {
          return Colors.amber;
        }
        return AppColors.checkInColor;
    }
  }*/
}
