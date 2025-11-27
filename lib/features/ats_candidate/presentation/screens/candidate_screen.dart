import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
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
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/candidate_action_provider.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/candidates_provider.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/payslip/presentation/widgets/pay_slip_download_options.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
  final String currentRoute =
      AppRouteConstants.atsCandidate; // Replace with actual current route

  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 6; // Change this to show how many items per page
  int pageWindowStart = 1; // first page in current window
  int pageWindowSize = 5; // show 5 numbers at a time

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCandidates();
    });
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

  // Build DataGridRows from applicantsData
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
  }

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
    );
    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 70, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 150, label: header('Name')),
      GridColumn(
        columnName: 'mobileNumber',
        width: 150,
        label: header('Mobile Number'),
      ),
      GridColumn(columnName: 'CV', width: 150, label: header('Attachment')),
      GridColumn(columnName: 'Experience', label: header('Experience')),
      GridColumn(columnName: 'Email', width: 200, label: header('Email')),
      GridColumn(
        columnName: 'Status',
        width: 140,
        label: header('Disposition'),
      ),
      GridColumn(
        columnName: 'Recruiter',
        width: 200,
        label: header('Recruiter'),
      ),
      GridColumn(columnName: 'Action', width: 200, label: header('Action')),
    ];
  }

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

    return Consumer<CandidatesProvider>(
      builder: (context, candidatesProvider, child) {
        final columns = _buildColumns();
        final List<DataGridRow> rows =
            candidatesProvider.status == CandidatesStatus.success
            ? _buildRows(candidatesProvider.candidates)
            : <DataGridRow>[];

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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: KText(
                            text: "Candidates",
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            //  color: AppColors.titleColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: KText(
                            text: "Manage your Candidates",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: theme
                                .textTheme
                                .bodyLarge
                                ?.color, //AppColors.greyColor,
                          ),
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
                                        KText(
                                          text: "Candidate List",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          // color: AppColors.titleColor,
                                        ),
                                        if (candidatesProvider.status ==
                                            CandidatesStatus.loading)
                                          SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    theme.primaryColor,
                                                  ),
                                            ),
                                          ),
                                      ],
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
                                            icon: SvgPicture.asset(
                                              AppAssetsConstants.filterIcon,
                                              height: 15,
                                              width: 15,
                                              fit: BoxFit.contain,
                                              //SVG IMAGE COLOR
                                              colorFilter: ColorFilter.mode(
                                                theme
                                                        .textTheme
                                                        .headlineLarge
                                                        ?.color ??
                                                    Colors.black,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            onPressed: () {
                                              print("Filter button tapped");
                                            },
                                            backgroundColor: theme
                                                .secondaryHeaderColor, //AppColors.secondaryColor AppColors.secondaryColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: KAtsGlowButton(
                                            text: "Candidates",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            textColor:
                                                theme.secondaryHeaderColor,
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
                                        ),
                                      ],
                                    ),
                                    KVerticalSpacer(height: 16.h),
                                  ],
                                ),
                              ),

                              // Handle different states
                              if (candidatesProvider.status ==
                                  CandidatesStatus.loading)
                                Padding(
                                  padding: EdgeInsets.all(50.h),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              else if (candidatesProvider.status ==
                                  CandidatesStatus.error)
                                Padding(
                                  padding: EdgeInsets.all(50.h),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        size: 48.sp,
                                        color: AppColors.softRed,
                                      ),
                                      SizedBox(height: 16.h),
                                      KText(
                                        text: candidatesProvider.errorMessage,
                                        fontSize: 14.sp,
                                        color: AppColors.greyColor,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(height: 16.h),
                                      ElevatedButton(
                                        onPressed: _fetchCandidates,
                                        child: Text('Retry'),
                                      ),
                                    ],
                                  ),
                                )
                              else if (candidatesProvider.status ==
                                  CandidatesStatus.success)
                                newData_table(
                                  columns,
                                  rows,
                                  candidatesProvider.candidates,
                                ),
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

  Color _getStatusColor(String? status) {
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
  }

  /// Data Table Widget
  ReusableDataGrid newData_table(
    List<GridColumn> columns,
    List<DataGridRow> rows,
    List<CandidateEntity> candidates,
  ) {
    return ReusableDataGrid(
      title: 'Applicants',
      allowSorting: false,
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        //App Theme Data
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        // Always use REAL API DATA
        final candidate = candidates[actualDataIndex];
        final value = cell.value;

        /// CV Column
        if (cell.columnName == 'CV') {
          final cvUrl = candidate.resume ?? "";

          final fileName = cvUrl.split("/").last;

          return InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => PdfDownloadBottomSheet(
                  onPdfTap: () async {
                    Navigator.pop(context);
                    await downloadPdfFromUrl(cvUrl);
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    fileName,
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.download_outlined, size: 16),
              ],
            ),
          );
        }

        /// Status Column
        if (cell.columnName == 'Status') {
          final status = candidate.disposition ?? "";
          return Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    color: _getStatusColor(status),
                  ),
                ),
              ),
            ),
          );
        }

        /// Action Column
        if (cell.columnName == 'Action') {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _actionButton(
                color: isDark
                    ? AppColors.approvedColorDark
                    : AppColors.approvedColor,
                icon: AppAssetsConstants.eyeIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              _actionButton(
                color: theme.primaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              _actionButton(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
                icon: AppAssetsConstants.deleteIcon,
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Candidate'),
                      content: Text(
                        'Are you sure you want to delete ${candidate.candidateName}?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm != true) return;

                  final provider = context.read<CandidateActionProvider>();

                  // Show loading
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Deleting candidate..."),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }

                  final success = await provider.deleteCandidate(candidate.id);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).clearSnackBars();

                    if (success) {
                      // ✅ Refresh the page
                      _fetchCandidates();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Deletion failed"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Candidate deleted successfully"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          );
        }

        /// Default Cell
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Text(value.toString(), style: TextStyle(fontSize: 12)),
        );
      },
    );
  }

  Widget _actionButton({
    required Color color,
    required String icon,
    VoidCallback? onTap,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(icon, color: Colors.white),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
