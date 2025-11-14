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
import 'package:fuoday/features/ats_candidate/presentation/provider/candidates_provider.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
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
    final webUserId = employeeDetails?['web_user_id']?.toString() ?? '54';

    context.read<CandidatesProvider>().fetchCandidates(webUserId);
  }
  // Sample data for candidates
  final List<Map<String, dynamic>> sampleData = [
    {
      "sno": 1,
      "name": "Aarav Sharma",
      "colum3": "15-09-2025",
      "colum4": "aarav_cv.pdf",
      "showDownload": true,
      "colum5": "Fresher",
      "colum6": "Flutter Developer",
      "colum7": "Selected",
      "avatarColor": Colors.blue,
      "initials": "AS",
    },
    {
      "sno": 2,
      "name": "Priya Verma",
      "colum3": "16-09-2025",
      "colum4": "priya_cv.pdf",
      "colum5": "2 yrs",
      "colum6": "test@gmail.com",
      "colum7": "On Hold",
      "colum8": "jeeva",
      "avatarColor": Colors.purple,
      "initials": "PV",
      "showDownload": true,
    },
    {
      "sno": 3,
      "name": "Rohan Gupta",
      "colum3": "3216549870",
      "colum4": "rohan_cv.pdf",
      "colum5": "1 yr",
      "colum6": "test@gmail.com",
      "colum7": "Rejected",
      "colum8": "raja",
      "avatarColor": Colors.orange,
      "initials": "RG",
      "showDownload": true,
    },
    {
      "sno": 4,
      "name": "Neha Singh",
      "colum3": "3216549870",
      "colum4": "neha_cv.pdf",
      "colum5": "3 yrs",
      "colum6": "test@gmail.com",
      "colum7": "In Progress",
      "colum8": "raj",
      "avatarColor": Colors.green,
      "initials": "NS",
      "showDownload": true,
    },
    {
      "sno": 5,
      "name": "Arjun Mehta",
      "colum3": "19-09-2025",
      "colum4": "arjun_cv.pdf",
      "colum5": "Fresher",
      "colum6": "QA Engineer",
      "colum7": "L1 60%",
      "avatarColor": Colors.red,
      "initials": "AM",
      "showDownload": true,
    },
    {
      "sno": 6,
      "name": "Simran Kaur",
      "colum3": "20-09-2025",
      "colum4": "simran_cv.pdf",
      "colum5": "4 yrs",
      "colum6": "Project Manager",
      "colum7": "HR Round",
      "avatarColor": Colors.teal,
      "initials": "SK",
      "showDownload": true,
    },
    {
      "sno": 7,
      "name": "Vikram Rao",
      "colum3": "21-09-2025",
      "colum4": "vikram_cv.pdf",
      "colum5": "2 yrs",
      "colum6": "Data Analyst",
      "colum7": "L2 70%",
      "avatarColor": Colors.cyan,
      "initials": "VR",
      "showDownload": true,
    },
    {
      "sno": 8,
      "name": "Ananya Nair",
      "colum3": "22-09-2025",
      "colum4": "ananya_cv.pdf",
      "colum5": "Fresher",
      "colum6": "AI Engineer",
      "colum7": "Selected",
      "avatarColor": Colors.indigo,
      "initials": "AN",
      "showDownload": true,
    },
    {
      "sno": 9,
      "name": "Karan Patel",
      "colum3": "23-09-2025",
      "colum4": "karan_cv.pdf",
      "colum5": "5 yrs",
      "colum6": "DevOps Engineer",
      "colum7": "L3 95%",
      "avatarColor": Colors.deepOrange,
      "initials": "KP",
      "showDownload": true,
    },
    {
      "sno": 10,
      "name": "Meera Iyer",
      "colum3": "24-09-2025",
      "colum4": "meera_cv.pdf",
      "colum5": "1 yr",
      "colum6": "Business Analyst",
      "colum7": "On Hold",
      "avatarColor": Colors.pink,
      "initials": "MI",
      "showDownload": true,
    },
    {
      "sno": 11,
      "name": "Rahul Kumar",
      "colum3": "25-09-2025",
      "colum4": "rahul_cv.pdf",
      "colum5": "3 yrs",
      "colum6": "Mobile Developer",
      "colum7": "Selected",
      "avatarColor": Colors.brown,
      "initials": "RK",
      "showDownload": true,
    },
    {
      "sno": 12,
      "name": "Sneha Reddy",
      "colum3": "26-09-2025",
      "colum4": "sneha_cv.pdf",
      "colum5": "2 yrs",
      "colum6": "Frontend Developer",
      "colum7": "In Progress",
      "avatarColor": Colors.amber,
      "initials": "SR",
      "showDownload": true,
    },
    {
      "sno": 13,
      "name": "Amit Agarwal",
      "colum3": "27-09-2025",
      "colum4": "amit_cv.pdf",
      "colum5": "4 yrs",
      "colum6": "Tech Lead",
      "colum7": "HR Round",
      "avatarColor": Colors.lightBlue,
      "initials": "AA",
      "showDownload": true,
    },
    {
      "sno": 14,
      "name": "Pooja Jain",
      "colum3": "28-09-2025",
      "colum4": "pooja_cv.pdf",
      "colum5": "1 yr",
      "colum6": "Content Writer",
      "colum7": "On Hold",
      "avatarColor": Colors.deepPurple,
      "initials": "PJ",
      "showDownload": true,
    },
    {
      "sno": 15,
      "name": "Rajesh Mishra",
      "colum3": "29-09-2025",
      "colum4": "rajesh_cv.pdf",
      "colum5": "6 yrs",
      "colum6": "System Admin",
      "colum7": "Rejected",
      "avatarColor": Colors.lime,
      "initials": "RM",
      "showDownload": true,
    },
    {
      "sno": 16,
      "name": "Rajesh Mishra",
      "colum3": "29-09-2025",
      "colum4": "rajesh_cv.pdf",
      "colum5": "6 yrs",
      "colum6": "System Admin",
      "colum7": "Rejected",
      "avatarColor": Colors.lime,
      "initials": "RM",
      "showDownload": true,
    },
  ];

  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows(List<CandidateEntity> candidates) {
    return candidates.asMap().entries.map((entry) {
      int index = entry.key;
      var data = entry.value;
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'SNo', value: index + 1),
          DataGridCell<String>(columnName: 'Name', value: data.candidateName),
          DataGridCell<String>(columnName: 'mobileNumber', value: data.mobileNumber),
          DataGridCell<String>(columnName: 'CV', value: data.resume),
          DataGridCell<String>(columnName: 'Experience', value: data.totalExperience),
          DataGridCell<String>(columnName: 'Email', value: data.email),
          DataGridCell<String>(columnName: 'Status', value: data.disposition),
          DataGridCell<String>(columnName: 'Recruiter', value: data.recruiterName),
          DataGridCell<String>(columnName: 'Action', value: "action"),
        ],
      );
    }).toList();
  }

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.greyColor,
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
      GridColumn(columnName: 'Status', width: 140, label: header('Disposition')),
      GridColumn(columnName: 'Recruiter', width: 200, label: header('Recruiter')),
      GridColumn(columnName: 'Action', width: 200, label: header('Action')),
    ];
  }

  // Getter methods for pagination
  int get totalPages => (sampleData.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedData {
    int totalPagesCount = (sampleData.length / itemsPerPage).ceil();

    // Ensure currentPage is within range
    if (currentPage > totalPagesCount) currentPage = totalPagesCount;
    if (currentPage < 1) currentPage = 1;

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (startIndex >= sampleData.length) return []; // safe guard
    if (endIndex > sampleData.length) endIndex = sampleData.length;

    return sampleData.sublist(startIndex, endIndex);
  }

  // Calculate display text for showing entries
  String get entriesDisplayText {
    if (sampleData.isEmpty) return "Showing 0 to 0 of 0 entries";

    int startIndex = (currentPage - 1) * itemsPerPage + 1;
    int endIndex = currentPage * itemsPerPage;
    if (endIndex > sampleData.length) endIndex = sampleData.length;

    return "Showing $startIndex to $endIndex of ${sampleData.length} entries";
  }

  @override
  void dispose() {
    jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    return Consumer<CandidatesProvider>(
      builder: (context, candidatesProvider, child) {
        final columns = _buildColumns();
        final List<DataGridRow> rows = candidatesProvider.status == CandidatesStatus.success
            ? _buildRows(candidatesProvider.candidates)
            : <DataGridRow>[];


        // Update grid data with counts
        final List<Map<String, dynamic>> gridAttendanceData = [
          {
            'icon': AppAssetsConstants.bookIcon,
            'title': 'Total Applied',
            'numberOfCount': candidatesProvider.counts?.applied.toString() ?? "0",
            'growth': "+5.1%",
          },
          {
            'title': 'Shortlisted Candidates',
            'numberOfCount': candidatesProvider.counts?.shortlisted.toString() ?? "0",
            'growth': "+5.1%",
            'icon': AppAssetsConstants.selectedIcon,
          },
          {
            'title': 'Hold Candidates',
            'numberOfCount': candidatesProvider.counts?.holded.toString() ?? "0",
            'growth': "+5.1%",
            'icon': AppAssetsConstants.holdIcon,
          },
          {
            'title': 'Rejected Candidates',
            'numberOfCount': candidatesProvider.counts?.rejected.toString() ?? "0",
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
              color: AppColors.atsHomepageBg,
              child: Padding(
                padding: EdgeInsets.all(16.w),
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
                          color: AppColors.titleColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: KText(
                          text: "Manage your Candidates",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Grid Cards with counts
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            employeeIconColor: AppColors.primaryColor,
                            employeePercentageColor: AppColors.checkInColor,
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

                              // SizedBox(height: 16.h),

                              /// 🔹 Upload Picker
                              KAtsUploadPickerTile(
                                backgroundcolor: AppColors.atsHomepageBg,
                                showOnlyView: context.filePickerProviderWatch
                                    .isPicked("resume"),
                                onViewTap: () {
                                  final pickedFile = context.filePickerProviderRead
                                      .getFile("resume");
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
                            color: AppColors.greyColor.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(7.69.r),
                          color: AppColors.secondaryColor,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: "Candidate List",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: AppColors.titleColor,
                                      ),
                                      if (candidatesProvider.status == CandidatesStatus.loading)
                                        SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  KVerticalSpacer(height: 16.h),
                                  Row(
                                    spacing: 20.w,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: KAtsGlowButton(
                                          text: "Filter",
                                          textColor: AppColors.greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          icon: SvgPicture.asset(
                                            AppAssetsConstants.filterIcon,
                                            height: 15,
                                            width: 15,
                                            fit: BoxFit.contain,
                                          ),
                                          onPressed: () {
                                            print("Filter button tapped");
                                          },
                                          backgroundColor: AppColors.secondaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: KAtsGlowButton(
                                          text: "Candidates",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          icon: SvgPicture.asset(
                                            AppAssetsConstants.addIcon,
                                            height: 15,
                                            width: 15,
                                            fit: BoxFit.contain,
                                          ),
                                          onPressed: () {
                                            print("Candidates button tapped");
                                            GoRouter.of(context).pushNamed(
                                              AppRouteConstants.atsCandidateInformationScreen,
                                            );
                                          },
                                          backgroundColor: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  KVerticalSpacer(height: 16.h),
                                ],
                              ),
                            ),

                            // Handle different states
                            if (candidatesProvider.status == CandidatesStatus.loading)
                              Padding(
                                padding: EdgeInsets.all(50.h),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            else if (candidatesProvider.status == CandidatesStatus.error)
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
                                      textAlign: TextAlign.center, fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 16.h),
                                    ElevatedButton(
                                      onPressed: _fetchCandidates,
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              )
                            else if (candidatesProvider.status == CandidatesStatus.success)
                                newData_table(columns, rows, candidatesProvider.candidates)

                          ],
                        ),
                      ),
                    ],
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
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(status).withOpacity(0.1),
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
          );
        }

        /// Action Column
        if (cell.columnName == 'Action') {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _actionButton(
                color: AppColors.approvedColor,
                icon: AppAssetsConstants.eyeIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              _actionButton(
                color: AppColors.primaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              _actionButton(
                color: AppColors.softRed,
                icon: AppAssetsConstants.deleteIcon,
                onTap: () {},
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
