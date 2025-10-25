import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_data_table.dart';
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
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:go_router/go_router.dart';
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
      "colum6": "Backend Developer",
      "colum7": "On Hold",
      "avatarColor": Colors.purple,
      "initials": "PV",
      "showDownload": true,
    },
    {
      "sno": 3,
      "name": "Rohan Gupta",
      "colum3": "17-09-2025",
      "colum4": "rohan_cv.pdf",
      "colum5": "1 yr",
      "colum6": "UI/UX Designer",
      "colum7": "Rejected",
      "avatarColor": Colors.orange,
      "initials": "RG",
      "showDownload": true,
    },
    {
      "sno": 4,
      "name": "Neha Singh",
      "colum3": "18-09-2025",
      "colum4": "neha_cv.pdf",
      "colum5": "3 yrs",
      "colum6": "Full Stack Developer",
      "colum7": "In Progress",
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
  List<DataGridRow> _buildRows() => sampleData.asMap().entries.map((entry) {
    int index = entry.key; // row index
    var data = entry.value;
    return DataGridRow(
      cells: [
        // S.No column
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'Date', value: data['colum3']),
        DataGridCell<String>(columnName: 'CV', value: data['colum4']),
        DataGridCell<String>(columnName: 'Experience', value: data['colum5']),
        DataGridCell<String>(columnName: 'Role', value: data['colum6']),
        DataGridCell<String>(columnName: 'Status', value: data['colum7']),
        DataGridCell<String>(columnName: 'Action', value: "action"),
      ],
    );
  }).toList();

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
        columnName: 'Date',
        width: 150,
        label: header('Interview Date'),
      ),
      GridColumn(columnName: 'CV', width: 150, label: header('Attachment')),
      GridColumn(columnName: 'Experience', label: header('Experience')),
      GridColumn(columnName: 'Role', width: 200, label: header('Role')),
      GridColumn(columnName: 'Status', width: 140, label: header('Status')),
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

    final headers = [
      _headers("S.No", 50.w),
      _headers("Name", 100.w),
      _headers("Interview Date", 120.w),
      _headers("Attachment", 100.w),
      _headers("Experience", 100.w),
      _headers("Role", 160.w),
      _headers("Status", 150.w),
      _headers("Action", 150.w),
    ];

    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.bookIcon, // ✅ SVG path
        'title': 'Total Applied',
        'numberOfCount': "3,450",
        'growth': "+5.1%",
      },
      {
        'title': 'Shortlisted Candidates',
        'numberOfCount': "1,234",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.selectedIcon, // ✅ SVG path
      },
      {
        'title': 'Hold Candidates',
        'numberOfCount': "588",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.holdIcon, // ✅ SVG path
      },
      {
        'title': 'Rejected Candidates',
        'numberOfCount': "98",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.rejectedIcon, // ✅ SVG path
      },
    ];
    final rows = _buildRows();
    final columns = _buildColumns();
    return PopScope(
      canPop: false, // Prevent default pop
      onPopInvokedWithResult: (didPop, result) async {
        // If not popped automatically
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
            // If already on Home → allow exiting app
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
          currentRoute: currentRoute, // This will highlight the current screen
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

                          SizedBox(height: 20.h),

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
                            // Filter Button
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

                            // Export file
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
                                    AppRouteConstants
                                        .atsCandidateInformationScreen,
                                  );
                                },
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        KVerticalSpacer(height: 16.h),

                        /// Old Data Table
                        // Data Table with paginated data
                        // SizedBox(
                        //   height: 330.h,
                        //   width:
                        //       1445.w, // 👈 Figma width (if you want it strict)
                        //   child: KAtsDataTable(
                        //     columnHeaders: headers,
                        //     rowData: paginatedData,
                        //     minWidth: 1150
                        //         .w, // 👈 match with figma width// Using paginated data
                        //   ),
                        // ),
                        //
                        // // Pagination
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [_buildPageNumbersRow()],
                        // ),
                        //
                        // SizedBox(height: 16.w),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     KText(
                        //       text: entriesDisplayText, // Dynamic entries text
                        //       fontSize:
                        //           MediaQuery.of(context).size.width * 0.03,
                        //       color: AppColors.greyColor,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //
                        //     // spacing between text and button
                        //     // SizedBox(
                        //     //   width: MediaQuery.of(context).size.width * 0.15,
                        //     // ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         // Show dropdown or bottom sheet to change items per page
                        //         _showItemsPerPageSelector();
                        //       },
                        //       child: Container(
                        //         padding: EdgeInsets.all(
                        //           MediaQuery.of(context).size.width * 0.02,
                        //         ),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             width: 0.8,
                        //             color: AppColors.greyColor.withOpacity(0.1),
                        //           ),
                        //           borderRadius: BorderRadius.circular(8.r),
                        //           color: AppColors.secondaryColor,
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             KText(
                        //               text: "Show $itemsPerPage",
                        //               fontSize:
                        //                   MediaQuery.of(context).size.width *
                        //                   0.025,
                        //               color: AppColors.titleColor,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //             Icon(
                        //               Icons.keyboard_arrow_down,
                        //               size:
                        //                   MediaQuery.of(context).size.width *
                        //                   0.04,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        /// New Data Table
                        newData_table(columns, rows),
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
  Padding newData_table(List<GridColumn> columns, List<DataGridRow> rows) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ReusableDataGrid(
        title: 'Applicants',
        allowSorting: false,
        columns: columns,
        rows: rows,
        totalRows: rows.length,
        initialRowsPerPage: 5,
        cellBuilder: (cell, rowIndex, actualDataIndex) {
          final value = cell.value;
          if (cell.columnName == 'CV') {
            final applicant = sampleData[actualDataIndex];
            final cv = applicant['colum4'] ?? "";
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cv),
                SizedBox(width: 4.w),
                Icon(
                  Icons.download_outlined,
                  size: 16.sp,
                  color: AppColors.greyColor,
                ),
              ],
            );
          }
          if (cell.columnName == 'Status') {
            final applicant = sampleData[actualDataIndex];
            final status = applicant['colum7'] ?? "";
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),

                child: Center(
                  child: KText(
                    text: status,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: _getStatusColor(status),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
          if (cell.columnName == 'Action') {
            Widget _actionButton({
              required Color color,
              required String icon,
              VoidCallback? onTap,
            }) {
              return Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: onTap,
                  icon: SvgPicture.asset(
                    icon,
                    height: 14.h,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.zero,
                ),
              );
            }

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
          // Default text cells
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(value.toString(), style: TextStyle(fontSize: 12.sp)),
          );
        },
        // cellBuilder: (cell, rowIndex, actualDataIndex) {
        //   final value = cell.value;
        //   if (cell.columnName == 'SNo') {
        //     return Container(
        //       alignment:
        //       Alignment.center, // Centers horizontally and vertically
        //       child: Text(cell.value.toString(), textAlign: TextAlign.center),
        //     );
        //   }
        //
        //   //  CV column
        //   if (cell.columnName == 'CV')
        //     final applicant = sampleData[actualDataIndex];
        //     final cv = applicant['colum4'] ?? "";
        //     return Row(
        //       children: [
        //         Text(cv),
        //         SizedBox(width: 4.w),
        //         Icon(
        //           Icons.download_outlined,
        //           size: 16.sp,
        //           color: AppColors.greyColor,
        //         ),
        //       ],
        //     );
        //   }
        //
        //
        //   if (cell.columnName == 'Action') {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         _actionButton(
        //           color: AppColors.primaryColor,
        //           icon: AppAssetsConstants.editIcon,
        //           onTap: () {},
        //         ),
        //         SizedBox(width: 8.w),
        //         _actionButton(
        //           color: AppColors.softRed,
        //           icon: AppAssetsConstants.deleteIcon,
        //           onTap: () {},
        //         ),
        //       ],
        //     );
        //   }

        // Default text cells
        // return Container(
        //   alignment: Alignment.centerLeft,
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        //   child: Text(value.toString(), style: TextStyle(fontSize: 12.sp)),
        // );
        // },
      ),
    );
  }

  SizedBox _headers(String text, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: KText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
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

  void _showItemsPerPageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              KText(
                text: "Items per page",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
              SizedBox(height: 16.h),
              ...([5, 6, 10, 15, 20].map(
                (count) => ListTile(
                  title: KText(
                    text: "Show $count items",
                    fontSize: 14.sp,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  trailing: itemsPerPage == count
                      ? Icon(Icons.check, color: AppColors.primaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      itemsPerPage = count;
                      currentPage = 1; // Reset to first page
                      pageWindowStart = 1; // Reset pagination window
                    });
                    Navigator.pop(context);
                  },
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
