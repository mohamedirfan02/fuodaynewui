import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_delete_confirm_dialog.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AllStatusListedTable extends StatefulWidget {
  final String searchQuery;
  const AllStatusListedTable({Key? key, required this.searchQuery})
    : super(key: key);

  @override
  State<AllStatusListedTable> createState() => _AllStatusListedTableState();
}

class _AllStatusListedTableState extends State<AllStatusListedTable> {
  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'interviewDate': '01 May 2025',
      'experience': '2 Years',
      'vacancy': 'Frontend Dev',
      'feedback': 'Selected',
      'attachment': 'cv.pdf',
      'stages': 'Hiring',
      'status': 'Approved',
      'action': 'View Profile',
    },
    {
      'name': 'Arjun Kumar',
      'jobId': '1002',
      'recruitmentId': 'R-502',
      'interviewDate': '03 May 2025',
      'experience': '5 Years',
      'vacancy': 'Backend Dev',
      'feedback': 'Pending',
      'attachment': 'resume.pdf',
      'stages': '1st Interview',
      'status': 'In Review',
      'action': 'Schedule Call',
    },
    {
      'name': 'Maria Joseph',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'interviewDate': '05 May 2025',
      'experience': '3 Years',
      'vacancy': 'UX Designer',
      'feedback': 'Rejected',
      'attachment': 'portfolio.pdf',
      'stages': '1st Interview',
      'status': 'Closed',
      'action': 'View Feedback',
    },
    {
      'name': 'Rahul Sharma',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'interviewDate': '08 May 2025',
      'experience': '1 Year',
      'vacancy': 'Support Engineer',
      'feedback': 'Selected',
      'attachment': 'cv.pdf',
      'stages': 'Hiring',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Samantha Lee',
      'jobId': '1005',
      'recruitmentId': 'R-505',
      'interviewDate': '10 May 2025',
      'experience': '4 Years',
      'vacancy': 'QA Tester',
      'feedback': 'Pending',
      'attachment': 'cv.pdf',
      'stages': 'Hiring',
      'status': 'In Review',
      'action': 'Evaluate Test',
    },
    {
      'name': 'Vikas Singh',
      'jobId': '1006',
      'recruitmentId': 'R-506',
      'interviewDate': '11 May 2025',
      'experience': '6 Years',
      'vacancy': 'Project Manager',
      'feedback': 'Selected',
      'attachment': 'resume.pdf',
      'stages': 'Hiring',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Fatima Noor',
      'jobId': '1007',
      'recruitmentId': 'R-507',
      'interviewDate': '12 May 2025',
      'experience': '2 Years',
      'vacancy': 'Business Analyst',
      'feedback': 'Rejected',
      'attachment': 'profile.pdf',
      'stages': '1st Interview',
      'status': 'Closed',
      'action': 'View Feedback',
    },
    {
      'name': 'Rohit Verma',
      'jobId': '1008',
      'recruitmentId': 'R-508',
      'interviewDate': '13 May 2025',
      'experience': '3 Years',
      'vacancy': 'Flutter Developer',
      'feedback': 'Pending',
      'attachment': 'cv.pdf',
      'stages': '1st Interview',
      'status': 'In Review',
      'action': 'Schedule Call',
    },
    {
      'name': 'Jennifer Park',
      'jobId': '1009',
      'recruitmentId': 'R-509',
      'interviewDate': '14 May 2025',
      'experience': '7 Years',
      'vacancy': 'Data Scientist',
      'feedback': 'Selected',
      'attachment': 'resume.pdf',
      'stages': 'Hiring',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Imran Khan',
      'jobId': '1010',
      'recruitmentId': 'R-510',
      'interviewDate': '15 May 2025',
      'experience': '2 Years',
      'vacancy': 'DevOps Engineer',
      'feedback': 'Pending',
      'attachment': 'cv.pdf',
      'stages': '1st Interview',
      'status': 'In Review',
      'action': 'Assign Task',
    },
    {
      'name': 'Nikita Desai',
      'jobId': '1011',
      'recruitmentId': 'R-511',
      'interviewDate': '16 May 2025',
      'experience': '1 Year',
      'vacancy': 'React Developer',
      'feedback': 'Rejected',
      'attachment': 'portfolio.pdf',
      'stages': '1st Interview',
      'status': 'Closed',
      'action': 'View Feedback',
    },
    {
      'name': 'Omar Ali',
      'jobId': '1012',
      'recruitmentId': 'R-512',
      'interviewDate': '17 May 2025',
      'experience': '6 Years',
      'vacancy': 'Full Stack Engineer',
      'feedback': 'Selected',
      'attachment': 'cv.pdf',
      'stages': '1st Interview',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Sophia Kim',
      'jobId': '1013',
      'recruitmentId': 'R-513',
      'interviewDate': '18 May 2025',
      'experience': '4 Years',
      'vacancy': 'Product Designer',
      'feedback': 'Pending',
      'attachment': 'portfolio.pdf',
      'stages': '1st Interview',
      'status': 'In Review',
      'action': 'Evaluate Task',
    },
    {
      'name': 'Karthik Vij',
      'jobId': '1014',
      'recruitmentId': 'R-514',
      'interviewDate': '19 May 2025',
      'experience': '3 Years',
      'vacancy': 'Python Developer',
      'feedback': 'Selected',
      'attachment': 'resume.pdf',
      'stages': 'Screening',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Linda George',
      'jobId': '1015',
      'recruitmentId': 'R-515',
      'interviewDate': '20 May 2025',
      'experience': '8 Years',
      'vacancy': 'HR Specialist',
      'feedback': 'Pending',
      'attachment': 'cv.pdf',
      'stages': 'Screening',
      'status': 'In Review',
      'action': 'Schedule Meeting',
    },
    {
      'name': 'Manish Patel',
      'jobId': '1016',
      'recruitmentId': 'R-516',
      'interviewDate': '21 May 2025',
      'experience': '2 Years',
      'vacancy': 'Technical Writer',
      'feedback': 'Rejected',
      'attachment': 'cv.pdf',
      'stages': 'Screening',
      'status': 'Closed',
      'action': 'View Feedback',
    },
    {
      'name': 'Chloe Brown',
      'jobId': '1017',
      'recruitmentId': 'R-517',
      'interviewDate': '22 May 2025',
      'experience': '5 Years',
      'vacancy': 'AI Engineer',
      'feedback': 'Pending',
      'attachment': 'resume.pdf',
      'stages': 'Applied',
      'status': 'In Review',
      'action': 'Assign Task',
    },
    {
      'name': 'George Miller',
      'jobId': '1018',
      'recruitmentId': 'R-518',
      'interviewDate': '23 May 2025',
      'experience': '9 Years',
      'vacancy': 'CTO',
      'feedback': 'Shortlisted',
      'attachment': 'profile.pdf',
      'stages': 'Screening',
      'status': 'In Review',
      'action': 'Schedule Final',
    },
    {
      'name': 'Priya S',
      'jobId': '1019',
      'recruitmentId': 'R-519',
      'interviewDate': '24 May 2025',
      'experience': '3 Years',
      'vacancy': 'Android Developer',
      'feedback': 'Selected',
      'attachment': 'cv.pdf',
      'stages': 'Applied',
      'status': 'Approved',
      'action': 'Send Offer',
    },
    {
      'name': 'Daniel Evans',
      'jobId': '1020',
      'recruitmentId': 'R-520',
      'interviewDate': '25 May 2025',
      'experience': '6 Years',
      'vacancy': 'Cyber Security Expert',
      'feedback': 'Pending',
      'attachment': 'resume.pdf',
      'stages': 'Applied',
      'status': 'In Review',
      'action': 'Assign Task',
    },
  ];

  late Map<String, String> _selectedStages;
  final List<String> stageOptions = [
    'Applied',
    'Screening',
    '1st Interview',
    'Hiring',
  ];

  @override
  void initState() {
    super.initState();
    // Store stages with unique keys (using name+jobId as key)
    _selectedStages = {};
    for (var applicant in applicantsData) {
      final key = '${applicant['name']}_${applicant['jobId']}';
      _selectedStages[key] = applicant['stages'] as String;
    }
  }

  @override
  void didUpdateWidget(AllStatusListedTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() {}); // Rebuild with new search
    }
  }

  //   Filter data based on search query
  List<Map<String, dynamic>> getFilteredData() {
    if (widget.searchQuery.isEmpty) {
      return applicantsData;
    }

    return applicantsData.where((applicant) {
      final name = applicant['name']?.toString().toLowerCase() ?? '';
      final jobId = applicant['jobId']?.toString().toLowerCase() ?? '';
      final recruitmentId =
          applicant['recruitmentId']?.toString().toLowerCase() ?? '';
      final vacancy = applicant['vacancy']?.toString().toLowerCase() ?? '';
      final experience =
          applicant['experience']?.toString().toLowerCase() ?? '';
      final status = applicant['status']?.toString().toLowerCase() ?? '';
      final stages = applicant['stages']?.toString().toLowerCase() ?? '';

      return name.contains(widget.searchQuery.toLowerCase()) ||
          jobId.contains(widget.searchQuery.toLowerCase()) ||
          recruitmentId.contains(widget.searchQuery.toLowerCase()) ||
          vacancy.contains(widget.searchQuery.toLowerCase()) ||
          experience.contains(widget.searchQuery.toLowerCase()) ||
          status.contains(widget.searchQuery.toLowerCase()) ||
          stages.contains(widget.searchQuery.toLowerCase());
    }).toList();
  }

  //   Build DataGridRows from FILTERED data ONLY
  List<DataGridRow> _buildRows() {
    final filteredData = getFilteredData();

    return filteredData.asMap().entries.map((entry) {
      int index = entry.key;
      var data = entry.value;
      return DataGridRow(
        cells: [
          DataGridCell<int>(columnName: 'SNo', value: index + 1),
          DataGridCell<String>(columnName: 'Name', value: data['name']),
          DataGridCell<String>(columnName: 'jobId', value: data['jobId']),
          DataGridCell<String>(
            columnName: 'recruitmentId',
            value: data['recruitmentId'],
          ),
          DataGridCell<String>(
            columnName: 'interviewDate',
            value: data['interviewDate'],
          ),
          DataGridCell<String>(
            columnName: 'Experience',
            value: data['experience'],
          ),
          DataGridCell<String>(columnName: 'Vacancy', value: data['vacancy']),
          DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),
          DataGridCell<String>(
            columnName: 'Attachment',
            value: data['attachment'],
          ),
          DataGridCell<String>(columnName: 'Stages', value: data['stages']),
          DataGridCell<String>(columnName: 'Status', value: data['status']),
          DataGridCell<String>(columnName: 'Action', value: data['action']),
        ],
      );
    }).toList();
  }

  List<GridColumn> _buildColumns(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 150, label: header('Name')),
      GridColumn(columnName: 'jobId', width: 90, label: header('Job ID')),
      GridColumn(
        columnName: 'recruitmentId',
        width: 140,
        label: header('Recruitment ID'),
      ),
      GridColumn(
        columnName: 'interviewDate',
        width: 150,
        label: header('Interview Date'),
      ),
      GridColumn(
        columnName: 'Experience',
        width: 120,
        label: header('Experience'),
      ),
      GridColumn(columnName: 'Vacancy', width: 120, label: header('Vacancy')),
      GridColumn(columnName: 'Feedback', width: 120, label: header('Feedback')),
      GridColumn(
        columnName: 'Attachment',
        width: 130,
        label: header('Attachment'),
      ),
      GridColumn(columnName: 'Stages', width: 150, label: header('Stages')),
      GridColumn(columnName: 'Status', width: 120, label: header('Status')),
      GridColumn(columnName: 'Action', width: 100, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = getFilteredData();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    //   Show "No results" message
    if (filteredData.isEmpty && widget.searchQuery.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
              SizedBox(height: 16.h),
              Text(
                'No results found for "${widget.searchQuery}"',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    //   Show table with ONLY filtered results
    return ReusableDataGrid(
      key: ValueKey(widget.searchQuery), //   Force rebuild on search change
      title: 'All Status (${filteredData.length} results)',
      columns: _buildColumns(context),
      rows: _buildRows(),
      totalRows: filteredData.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        if (actualDataIndex >= filteredData.length) {
          return const SizedBox();
        }

        //   Get current filtered item
        final currentApplicant = filteredData[actualDataIndex];
        final applicantKey =
            '${currentApplicant['name']}_${currentApplicant['jobId']}';
        final value = cell.value;

        //  CV column
        if (cell.columnName == 'Attachment') {
          final cv = currentApplicant['attachment'] ?? "";
          return Row(
            children: [
              Text(cv),
              Spacer(),
              Icon(
                Icons.sim_card_download_outlined,
                size: 16.sp,
                color: theme.textTheme.bodyLarge?.color,
              ),
              SizedBox(width: 5.w),
            ],
          );
        }

        // Stages dropdown
        if (cell.columnName == 'Stages') {
          final status =
              _selectedStages[applicantKey] ?? currentApplicant['stages'];

          Color bgColor;
          Color textColor;
          switch (status.toLowerCase()) {
            case 'selected':
              bgColor = AppColors.checkInColor.withValues(alpha: .2);
              textColor = isDark
                  ? AppColors.checkInColorDark
                  : AppColors.checkInColor;
              break;
            case 'rejected':
              bgColor = AppColors.softRed.withValues(alpha: .2);
              textColor = isDark ? AppColors.softRedDark : AppColors.softRed;
              break;
            case 'holding':
              bgColor = Colors.yellow.withValues(alpha: .2);
              textColor = Colors.yellow.shade900;
              break;
            default:
              bgColor = Colors.grey.shade200;
              textColor = Colors.black;
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: DropdownButton<String>(
              value: status,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              dropdownColor: theme.secondaryHeaderColor,
              iconEnabledColor: theme.textTheme.headlineLarge?.color
                  ?.withValues(alpha: 0.5),
              selectedItemBuilder: (context) {
                return stageOptions.map((stage) {
                  return Center(
                    child: Text(
                      stage,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }).toList();
              },
              items: stageOptions.map((stage) {
                return DropdownMenuItem(
                  value: stage,
                  child: Text(
                    stage,
                    style: TextStyle(
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedStages[applicantKey] = val;
                    currentApplicant['stages'] = val;
                  });
                }
              },
            ),
          );
        }

        /// Status Column
        if (cell.columnName == 'Status') {
          final status = cell.value.toString();
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.checkInColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(fontSize: 11, color: AppColors.checkInColor),
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
              ActionButtonWidget(
                color: theme.primaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              ActionButtonWidget(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
                icon: AppAssetsConstants.deleteIcon,
                onTap: () async {
                  // 👇 new dialog code here
                  final confirm = await showDialog<bool>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DeleteConfirmationDialog(
                      title: "Delete Confirmation",
                      message:
                          "Are you sure you want to delete this candidate?",
                      onDelete: () {
                        print("Candidate Deleted");
                      },
                    ),
                  );

                  if (confirm == true) {
                    print("Candidate Deleted");
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
}

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final Color color;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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

///ShortlistedTable

class ShortlistedTable extends StatelessWidget {
  final List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'phone': '9876543210',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '5 LPA',
      'expectedCTC': '6 LPA',
      'attachment': 'cv1.pdf',
      'role': 'Frontend Dev',
      'feedback': 'Excellent',
      'status': 'Shortlisted',
      'action': 'View Profile',
    },
    {
      'name': 'Arjun Kumar',
      'jobId': '1002',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'recruitmentId': 'R-502',
      'phone': '9123456780',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '8 LPA',
      'expectedCTC': '10 LPA',
      'attachment': 'cv2.pdf',
      'role': 'Backend Dev',
      'feedback': 'Good',
      'status': 'Shortlisted',
      'action': 'Schedule Call',
    },
    {
      'name': 'Samantha Lee',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'phone': '9988776655',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '7 LPA',
      'expectedCTC': '8 LPA',
      'attachment': 'cv3.pdf',
      'role': 'QA Tester',
      'feedback': 'Good',
      'status': 'Shortlisted',
      'action': 'Evaluate Test',
    },
    {
      'name': 'Rohit Verma',
      'email': 'pristia@gmail.com',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'phone': '9871234567',
      'totalExperience': '6 Years',
      'relevantExperience': '5 Years',
      'currentCTC': '10 LPA',
      'expectedCTC': '12 LPA',
      'attachment': 'cv4.pdf',
      'role': 'Flutter Developer',
      'feedback': 'Excellent',
      'status': 'Shortlisted',
      'action': 'Schedule Call',
    },
    {
      'name': 'Maria Joseph',
      'email': 'pristia@gmail.com',

      'jobId': '1005',
      'recruitmentId': 'R-505',
      'phone': '9900112233',
      'totalExperience': '3 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '6 LPA',
      'expectedCTC': '7 LPA',
      'attachment': 'cv5.pdf',
      'role': 'UX Designer',
      'feedback': 'Good',
      'status': 'Shortlisted',
      'action': 'View Profile',
    },
    {
      'name': 'Fatima Noor',
      'email': 'pristia@gmail.com',

      'jobId': '1006',
      'recruitmentId': 'R-506',
      'phone': '9811223344',
      'totalExperience': '2 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '4 LPA',
      'expectedCTC': '5 LPA',
      'attachment': 'cv6.pdf',
      'role': 'Business Analyst',
      'feedback': 'Excellent',
      'status': 'Shortlisted',
      'action': 'View Feedback',
    },
    {
      'name': 'Karthik Reddy',
      'email': 'pristia@gmail.com',

      'jobId': '1007',
      'recruitmentId': 'R-507',
      'phone': '9899887766',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '9 LPA',
      'expectedCTC': '10 LPA',
      'attachment': 'cv7.pdf',
      'role': 'Fullstack Developer',
      'feedback': 'Good',
      'status': 'Shortlisted',
      'action': 'Schedule Call',
    },
    {
      'name': 'Neha Sharma',
      'email': 'pristia@gmail.com',

      'jobId': '1008',
      'recruitmentId': 'R-508',
      'phone': '9876541122',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '5 LPA',
      'expectedCTC': '6 LPA',
      'attachment': 'cv8.pdf',
      'role': 'Frontend Developer',
      'feedback': 'Excellent',
      'status': 'Shortlisted',
      'action': 'View Profile',
    },
    {
      'name': 'Vikram Singh',
      'email': 'pristia@gmail.com',

      'jobId': '1009',
      'recruitmentId': 'R-509',
      'phone': '9911223344',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '7 LPA',
      'expectedCTC': '8 LPA',
      'attachment': 'cv9.pdf',
      'role': 'Backend Developer',
      'feedback': 'Good',
      'status': 'Shortlisted',
      'action': 'Schedule Call',
    },
    {
      'name': 'Ananya Gupta',
      'email': 'pristia@gmail.com',

      'jobId': '1010',
      'recruitmentId': 'R-510',
      'phone': '9887766554',
      'totalExperience': '2 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '4 LPA',
      'expectedCTC': '5 LPA',
      'attachment': 'cv10.pdf',
      'role': 'QA Analyst',
      'feedback': 'Excellent',
      'status': 'Shortlisted',
      'action': 'Evaluate Test',
    },
  ];

  ShortlistedTable({super.key});

  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key;
    var data = entry.value;
    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobId', value: data['jobId']),
        DataGridCell<String>(
          columnName: 'RecruitmentId',
          value: data['recruitmentId'],
        ),
        DataGridCell<String>(columnName: 'Phone', value: data['phone']),
        DataGridCell<String>(
          columnName: 'TotalExperience',
          value: data['totalExperience'],
        ),
        DataGridCell<String>(
          columnName: 'RelevantExperience',
          value: data['relevantExperience'],
        ),
        DataGridCell<String>(
          columnName: 'CurrentCTC',
          value: data['currentCTC'],
        ),
        DataGridCell<String>(
          columnName: 'ExpectedCTC',
          value: data['expectedCTC'],
        ),
        DataGridCell<String>(
          columnName: 'Attachment',
          value: data['attachment'],
        ),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),
        DataGridCell<String>(columnName: 'Status', value: data['status']),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  List<GridColumn> _buildColumns(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 180, label: header('Name')),
      GridColumn(columnName: 'JobId', width: 90, label: header('Job ID')),
      GridColumn(
        columnName: 'RecruitmentId',
        width: 140,
        label: header('Recruitment ID'),
      ),
      GridColumn(
        columnName: 'Phone',
        width: 120,
        label: header('Phone Number'),
      ),
      GridColumn(
        columnName: 'TotalExperience',
        width: 150,
        label: header('Total Experience'),
      ),
      GridColumn(
        columnName: 'RelevantExperience',
        width: 160,
        label: header('Relevant Experience'),
      ),
      GridColumn(
        columnName: 'CurrentCTC',
        width: 120,
        label: header('Current CTC'),
      ),
      GridColumn(
        columnName: 'ExpectedCTC',
        width: 120,
        label: header('Expected CTC'),
      ),
      GridColumn(
        columnName: 'Attachment',
        width: 130,
        label: header('Attachment'),
      ),
      GridColumn(columnName: 'Role', width: 120, label: header('Role')),
      GridColumn(columnName: 'Feedback', width: 120, label: header('Feedback')),
      GridColumn(columnName: 'Status', width: 120, label: header('Status')),
      GridColumn(columnName: 'Action', width: 180, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ReusableDataGrid(
      title: 'Shortlisted Candidates',
      columns: _buildColumns(context),
      rows: _buildRows(),
      totalRows: applicantsData.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        //App Theme Data
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final atsPrimaryColor = Theme.of(context).colorScheme.primary;

        // Always use REAL API DATA
        if (actualDataIndex >= applicantsData.length) {
          return const SizedBox(); // prevents RangeError
        }

        final value = cell.value;
        if (cell.columnName == 'Name') {
          final applicant = applicantsData[actualDataIndex];
          final fullName = applicant['name'] ?? "";
          final email = applicant['email'] ?? "";
          //final color = applicant['avatarColor'] ?? Colors.grey;

          // Get initials from full name
          String getInitials(String name) {
            final parts = name.split(' ');
            if (parts.length == 1) return parts[0][0].toUpperCase();
            return (parts[0][0] + parts[1][0]).toUpperCase();
          }

          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.checkInColor.withValues(
                    alpha: 0.1,
                  ),
                  radius: 12.r,
                  child: KText(
                    text: getInitials(fullName),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.checkInColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: fullName,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          //  color: AppColors.titleColor,
                          textAlign: TextAlign.center,
                        ),
                        KText(
                          text: email,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        //  CV column
        if (cell.columnName == 'Attachment') {
          final applicant = applicantsData[actualDataIndex];
          final cv = applicant['attachment'] ?? "";
          return Row(
            children: [
              Text(cv),
              Spacer(),
              Icon(
                Icons.sim_card_download_outlined,
                size: 16.sp,
                color: theme.textTheme.bodyLarge?.color,
                //AppColors.greyColor,,
              ),
              SizedBox(width: 5.w),
            ],
          );
        }

        /// Status Column
        if (cell.columnName == 'Status') {
          final status = cell.value.toString(); // ⬅️ take current row value
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.checkInColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(fontSize: 11, color: AppColors.checkInColor),
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
              ActionButtonWidget(
                color: AppColors.checkInColor.withValues(alpha: 0.7),
                icon: AppAssetsConstants.checkIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              ActionButtonWidget(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
                icon: AppAssetsConstants.cancelIcon,
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Candidate'),
                      content: Text('Are you sure you want to delete ?'),
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

                  // if (confirm != true) return;

                  //  final provider = context.read<CandidateActionProvider>();

                  // Show loading
                  // if (context.mounted) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("Deleting candidate..."),
                  //       duration: Duration(seconds: 1),
                  //     ),
                  //   );
                  // }
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
}

//==================Holed Table============

class HoledTable extends StatefulWidget {
  HoledTable({super.key});

  @override
  State<HoledTable> createState() => _HoledTableState();
}

class _HoledTableState extends State<HoledTable> {
  final List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'phone': '9876543210',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '₹5,00,000',
      'lastUpdatedDate': '08 Nov 2025',
      'expectedCTC': '₹6,00,000',
      'attachment': 'cv1.pdf',
      'role': 'Frontend Dev',
      'feedback': 'Excellent',
      'stage': 'Hiring',
      'status': 'Hold',
      'action': 'View Profile',
    },
    {
      'name': 'Arjun Kumar',
      'email': 'arjun@gmail.com',
      'jobId': '1002',
      'recruitmentId': 'R-502',
      'phone': '9988776655',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '₹7,00,000',
      'lastUpdatedDate': '10 Nov 2025',
      'expectedCTC': '₹8,00,000',
      'attachment': 'cv2.pdf',
      'role': 'Backend Dev',
      'feedback': 'Good',
      'stage': '1st Interview',
      'status': 'Hold',
      'action': 'Schedule Call',
    },
    {
      'name': 'Samantha Lee',
      'email': 'samantha@gmail.com',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'phone': '9090909090',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '₹9,00,000',
      'lastUpdatedDate': '11 Nov 2025',
      'expectedCTC': '₹10,00,000',
      'attachment': 'cv3.pdf',
      'role': 'UI/UX Designer',
      'feedback': 'Good',
      'stage': '1st Interview',
      'status': 'Hold',
      'action': 'Evaluate Test',
    },
    {
      'name': 'Rohit Verma',
      'email': 'rohit@gmail.com',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'phone': '8765432109',
      'totalExperience': '6 Years',
      'relevantExperience': '5 Years',
      'currentCTC': '₹11,00,000',
      'lastUpdatedDate': '12 Nov 2025',
      'expectedCTC': '₹13,00,000',
      'attachment': 'cv4.pdf',
      'role': 'Full Stack Dev',
      'feedback': 'Excellent',
      'stage': 'Screening',
      'status': 'Hold',
      'action': 'Schedule Call',
    },
    {
      'name': 'Maria Joseph',
      'email': 'maria@gmail.com',
      'jobId': '1005',
      'recruitmentId': 'R-505',
      'phone': '9091223344',
      'totalExperience': '2 Years',
      'relevantExperience': '1 Year',
      'currentCTC': '₹3,00,000',
      'lastUpdatedDate': '09 Nov 2025',
      'expectedCTC': '₹5,00,000',
      'attachment': 'cv5.pdf',
      'role': 'QA Tester',
      'feedback': 'Good',
      'stage': 'Screening',
      'status': 'Hold',
      'action': 'View Profile',
    },
    {
      'name': 'Fatima Noor',
      'email': 'fatima@gmail.com',
      'jobId': '1006',
      'recruitmentId': 'R-506',
      'phone': '9988112200',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '₹7,00,000',
      'lastUpdatedDate': '13 Nov 2025',
      'expectedCTC': '₹9,00,000',
      'attachment': 'cv6.pdf',
      'role': 'Android Dev',
      'feedback': 'Excellent',
      'stage': 'Screening',
      'status': 'Hold',
      'action': 'View Feedback',
    },
    {
      'name': 'Karthik Reddy',
      'email': 'karthik@gmail.com',
      'jobId': '1007',
      'recruitmentId': 'R-507',
      'phone': '9000011122',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '₹8,00,000',
      'lastUpdatedDate': '14 Nov 2025',
      'expectedCTC': '₹10,00,000',
      'attachment': 'cv7.pdf',
      'role': 'Flutter Dev',
      'feedback': 'Good',
      'stage': 'Screening',
      'status': 'Hold',
      'action': 'Schedule Call',
    },
    {
      'name': 'Neha Sharma',
      'email': 'neha@gmail.com',
      'jobId': '1008',
      'recruitmentId': 'R-508',
      'phone': '7777888899',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '₹6,00,000',
      'lastUpdatedDate': '15 Nov 2025',
      'expectedCTC': '₹7,00,000',
      'attachment': 'cv8.pdf',
      'role': 'React Developer',
      'feedback': 'Excellent',
      'stage': 'Applied',
      'status': 'Hold',
      'action': 'View Profile',
    },
    {
      'name': 'Vikram Singh',
      'email': 'vikram@gmail.com',
      'jobId': '1009',
      'recruitmentId': 'R-509',
      'phone': '8888999988',
      'totalExperience': '7 Years',
      'relevantExperience': '6 Years',
      'currentCTC': '₹12,00,000',
      'lastUpdatedDate': '16 Nov 2025',
      'expectedCTC': '₹14,00,000',
      'attachment': 'cv9.pdf',
      'role': 'DevOps Engineer',
      'feedback': 'Good',
      'stage': 'Applied',
      'status': 'Hold',
      'action': 'Schedule Call',
    },
    {
      'name': 'Ananya Gupta',
      'email': 'ananya@gmail.com',
      'jobId': '1010',
      'recruitmentId': 'R-510',
      'phone': '7777000011',
      'totalExperience': '2 Years',
      'relevantExperience': '1 Year',
      'currentCTC': '₹4,00,000',
      'lastUpdatedDate': '17 Nov 2025',
      'expectedCTC': '₹5,00,000',
      'attachment': 'cv10.pdf',
      'role': 'Business Analyst',
      'feedback': 'Excellent',
      'stage': 'Applied',
      'status': 'Hold',
      'action': 'Evaluate Test',
    },
  ];
  late List<String> _selectedStages;
  final List<String> stageOptions = [
    'Applied',
    'Screening',
    '1st Interview',
    'Hiring',
  ];
  @override
  void initState() {
    super.initState();
    _selectedStages = applicantsData.map((e) => e['stage'] as String).toList();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _fetchCandidates();
    // });
  }

  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key;
    var data = entry.value;
    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobId', value: data['jobId']),
        DataGridCell<String>(
          columnName: 'RecruitmentId',
          value: data['recruitmentId'],
        ),
        DataGridCell<String>(columnName: 'Phone', value: data['phone']),
        DataGridCell<String>(
          columnName: 'TotalExperience',
          value: data['totalExperience'],
        ),
        DataGridCell<String>(
          columnName: 'RelevantExperience',
          value: data['relevantExperience'],
        ),
        DataGridCell<String>(
          columnName: 'CurrentCTC',
          value: data['currentCTC'],
        ),

        /// 🔹 Added here (after Current CTC)
        DataGridCell<String>(
          columnName: 'LastUpdatedDate',
          value: data['lastUpdatedDate'],
        ),

        DataGridCell<String>(
          columnName: 'ExpectedCTC',
          value: data['expectedCTC'],
        ),
        DataGridCell<String>(
          columnName: 'Attachment',
          value: data['attachment'],
        ),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),

        /// 🔹 Added here (after Feedback)
        DataGridCell<String>(columnName: 'Stages', value: data['stage']),

        DataGridCell<String>(columnName: 'Status', value: data['status']),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  List<GridColumn> _buildColumns(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 160, label: header('Name')),
      GridColumn(columnName: 'JobId', width: 90, label: header('Job ID')),
      GridColumn(
        columnName: 'RecruitmentId',
        width: 140,
        label: header('Recruitment ID'),
      ),
      GridColumn(
        columnName: 'Phone',
        width: 130,
        label: header('Phone Number'),
      ),
      GridColumn(
        columnName: 'TotalExperience',
        width: 130,
        label: header('Total Experience'),
      ),
      GridColumn(
        columnName: 'RelevantExperience',
        width: 170,
        label: header('Relevant Experience'),
      ),
      GridColumn(
        columnName: 'CurrentCTC',
        width: 110,
        label: header('Current CTC'),
      ),
      GridColumn(
        columnName: 'LastUpdatedDate',
        width: 150,
        label: header('Last Updated Date'),
      ),
      GridColumn(
        columnName: 'ExpectedCTC',
        width: 120,
        label: header('Expected CTC'),
      ),
      GridColumn(
        columnName: 'Attachment',
        width: 130,
        label: header('Attachment'),
      ),
      GridColumn(columnName: 'Role', width: 150, label: header('Role')),
      GridColumn(columnName: 'Feedback', width: 120, label: header('Feedback')),
      GridColumn(columnName: 'Stages', width: 150, label: header('Stages')),
      GridColumn(columnName: 'Status', width: 120, label: header('Status')),
      GridColumn(columnName: 'Action', width: 180, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ReusableDataGrid(
      title: 'Holed Candidates',
      columns: _buildColumns(context),
      rows: _buildRows(),
      totalRows: applicantsData.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        //App Theme Data
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final atsPrimaryColor = Theme.of(context).colorScheme.primary;

        // Always use REAL API DATA
        if (actualDataIndex >= applicantsData.length) {
          return const SizedBox(); // prevents RangeError
        }

        final value = cell.value;
        if (cell.columnName == 'Name') {
          final applicant = applicantsData[actualDataIndex];
          final fullName = applicant['name'] ?? "";
          final email = applicant['email'] ?? "";
          //final color = applicant['avatarColor'] ?? Colors.grey;

          // Get initials from full name
          String getInitials(String name) {
            final parts = name.split(' ');
            if (parts.length == 1) return parts[0][0].toUpperCase();
            return (parts[0][0] + parts[1][0]).toUpperCase();
          }

          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.checkInColor.withValues(
                    alpha: 0.1,
                  ),
                  radius: 12.r,
                  child: KText(
                    text: getInitials(fullName),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.checkInColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: fullName,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          //  color: AppColors.titleColor,
                          textAlign: TextAlign.center,
                        ),
                        KText(
                          text: email,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        //  CV column
        if (cell.columnName == 'Attachment') {
          final applicant = applicantsData[actualDataIndex];
          final cv = applicant['attachment'] ?? "";
          return Row(
            children: [
              Text(cv),
              Spacer(),
              Icon(
                Icons.sim_card_download_outlined,
                size: 16.sp,
                color: theme.textTheme.bodyLarge?.color,
                //AppColors.greyColor,,
              ),
              SizedBox(width: 5.w),
            ],
          );
        }

        ///Stages
        if (cell.columnName == 'Stages') {
          final status = _selectedStages[actualDataIndex];

          // 🔹 Color mapping for container & text
          Color bgColor;
          Color textColor;
          switch (status.toLowerCase()) {
            case 'selected':
              bgColor = AppColors.checkInColor.withValues(alpha: .2);
              textColor = isDark
                  ? AppColors.checkInColorDark
                  : AppColors.checkInColor;
              break;
            case 'rejected':
              bgColor = AppColors.softRed.withValues(alpha: .2);
              textColor = isDark ? AppColors.softRedDark : AppColors.softRed;
              break;
            case 'holding':
              bgColor = Colors.yellow.withValues(alpha: .2);
              textColor = Colors.yellow.shade900;
              break;
            default:
              bgColor = Colors.grey.shade200;
              textColor = Colors.black;
          }

          return Container(
            // height: 20.h,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // color: bgColor, // 🔹 Container background color
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButton<String>(
              value: status,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              dropdownColor: theme
                  .secondaryHeaderColor, // 🔹 White background for dropdown menu
              iconEnabledColor:
                  theme.textTheme.headlineLarge?.color, // 🔹  arrow icon
              selectedItemBuilder: (context) {
                // 🔹 This controls how the selected item appears in the container
                return stageOptions.map((stage) {
                  return Center(
                    child: Text(
                      stage,
                      style: TextStyle(
                        color: textColor, // 🔹 Colored text for selected item
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }).toList();
              },
              items: stageOptions.map((stage) {
                return DropdownMenuItem(
                  value: stage,
                  child: Text(
                    stage,
                    style: TextStyle(
                      color: theme
                          .textTheme
                          .headlineLarge
                          ?.color, // 🔹 Black text in dropdown items
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedStages[actualDataIndex] = val;
                    applicantsData[actualDataIndex]['stage'] = val;
                  });
                }
              },
            ),
          );
        }

        /// Status Column
        if (cell.columnName == 'Status') {
          final status = cell.value.toString(); // ⬅️ take current row value
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.completedColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.completedColor,
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
              ActionButtonWidget(
                color: atsPrimaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              ActionButtonWidget(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
                icon: AppAssetsConstants.deleteIcon,
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Candidate'),
                      content: Text('Are you sure you want to delete ?'),
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

                  // if (confirm != true) return;

                  //  final provider = context.read<CandidateActionProvider>();

                  // Show loading
                  // if (context.mounted) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("Deleting candidate..."),
                  //       duration: Duration(seconds: 1),
                  //     ),
                  //   );
                  // }
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
}

//==========================

class RejectedTable extends StatefulWidget {
  RejectedTable({super.key});

  @override
  State<RejectedTable> createState() => _RejectedTableState();
}

class _RejectedTableState extends State<RejectedTable> {
  final List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'phone': '9876543210',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '₹5,00,000',
      'expectedCTC': '₹6,00,000',
      'attachment': 'cv1.pdf',
      'role': 'Frontend Dev',
      'feedback': 'Excellent',
      'stage': 'Hiring',
      'status': 'Rejected',
      'action': 'View Profile',
    },
    {
      'name': 'Arjun Kumar',
      'email': 'arjun@gmail.com',
      'jobId': '1002',
      'recruitmentId': 'R-502',
      'phone': '9988776655',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '₹7,00,000',
      'expectedCTC': '₹8,00,000',
      'attachment': 'cv2.pdf',
      'role': 'Backend Dev',
      'feedback': 'Good',
      'stage': '1st Interview',
      'status': 'Rejected',
      'action': 'Schedule Call',
    },
    {
      'name': 'Samantha Lee',
      'email': 'samantha@gmail.com',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'phone': '9090909090',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '₹9,00,000',
      'expectedCTC': '₹10,00,000',
      'attachment': 'cv3.pdf',
      'role': 'UI/UX Designer',
      'feedback': 'Good',
      'stage': '1st Interview',
      'status': 'Rejected',
      'action': 'Evaluate Test',
    },
    {
      'name': 'Rohit Verma',
      'email': 'rohit@gmail.com',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'phone': '8765432109',
      'totalExperience': '6 Years',
      'relevantExperience': '5 Years',
      'currentCTC': '₹11,00,000',
      'expectedCTC': '₹13,00,000',
      'attachment': 'cv4.pdf',
      'role': 'Full Stack Dev',
      'feedback': 'Excellent',
      'stage': 'Screening',
      'status': 'Rejected',
      'action': 'Schedule Call',
    },
    {
      'name': 'Maria Joseph',
      'email': 'maria@gmail.com',
      'jobId': '1005',
      'recruitmentId': 'R-505',
      'phone': '9091223344',
      'totalExperience': '2 Years',
      'relevantExperience': '1 Year',
      'currentCTC': '₹3,00,000',
      'expectedCTC': '₹5,00,000',
      'attachment': 'cv5.pdf',
      'role': 'QA Tester',
      'feedback': 'Good',
      'stage': 'Screening',
      'status': 'Rejected',
      'action': 'View Profile',
    },
    {
      'name': 'Fatima Noor',
      'email': 'fatima@gmail.com',
      'jobId': '1006',
      'recruitmentId': 'R-506',
      'phone': '9988112200',
      'totalExperience': '4 Years',
      'relevantExperience': '3 Years',
      'currentCTC': '₹7,00,000',
      'expectedCTC': '₹9,00,000',
      'attachment': 'cv6.pdf',
      'role': 'Android Dev',
      'feedback': 'Excellent',
      'stage': 'Screening',
      'status': 'Rejected',
      'action': 'View Feedback',
    },
    {
      'name': 'Karthik Reddy',
      'email': 'karthik@gmail.com',
      'jobId': '1007',
      'recruitmentId': 'R-507',
      'phone': '9000011122',
      'totalExperience': '5 Years',
      'relevantExperience': '4 Years',
      'currentCTC': '₹8,00,000',
      'expectedCTC': '₹10,00,000',
      'attachment': 'cv7.pdf',
      'role': 'Flutter Dev',
      'feedback': 'Good',
      'stage': 'Screening',
      'status': 'Rejected',
      'action': 'Schedule Call',
    },
    {
      'name': 'Neha Sharma',
      'email': 'neha@gmail.com',
      'jobId': '1008',
      'recruitmentId': 'R-508',
      'phone': '7777888899',
      'totalExperience': '3 Years',
      'relevantExperience': '2 Years',
      'currentCTC': '₹6,00,000',
      'expectedCTC': '₹7,00,000',
      'attachment': 'cv8.pdf',
      'role': 'React Developer',
      'feedback': 'Excellent',
      'stage': 'Applied',
      'status': 'Rejected',
      'action': 'View Profile',
    },
    {
      'name': 'Vikram Singh',
      'email': 'vikram@gmail.com',
      'jobId': '1009',
      'recruitmentId': 'R-509',
      'phone': '8888999988',
      'totalExperience': '7 Years',
      'relevantExperience': '6 Years',
      'currentCTC': '₹12,00,000',
      'expectedCTC': '₹14,00,000',
      'attachment': 'cv9.pdf',
      'role': 'DevOps Engineer',
      'feedback': 'Good',
      'stage': 'Applied',
      'status': 'Rejected',
      'action': 'Schedule Call',
    },
    {
      'name': 'Ananya Gupta',
      'email': 'ananya@gmail.com',
      'jobId': '1010',
      'recruitmentId': 'R-510',
      'phone': '7777000011',
      'totalExperience': '2 Years',
      'relevantExperience': '1 Year',
      'currentCTC': '₹4,00,000',
      'expectedCTC': '₹5,00,000',
      'attachment': 'cv10.pdf',
      'role': 'Business Analyst',
      'feedback': 'Excellent',
      'stage': 'Applied',
      'status': 'Rejected',
      'action': 'Evaluate Test',
    },
  ];
  late List<String> _selectedStages;
  final List<String> stageOptions = [
    'Applied',
    'Screening',
    '1st Interview',
    'Hiring',
  ];
  @override
  void initState() {
    super.initState();
    _selectedStages = applicantsData.map((e) => e['stage'] as String).toList();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _fetchCandidates();
    // });
  }

  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key;
    var data = entry.value;
    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobId', value: data['jobId']),
        DataGridCell<String>(
          columnName: 'RecruitmentId',
          value: data['recruitmentId'],
        ),
        DataGridCell<String>(columnName: 'Phone', value: data['phone']),
        DataGridCell<String>(
          columnName: 'TotalExperience',
          value: data['totalExperience'],
        ),
        DataGridCell<String>(
          columnName: 'RelevantExperience',
          value: data['relevantExperience'],
        ),
        DataGridCell<String>(
          columnName: 'CurrentCTC',
          value: data['currentCTC'],
        ),

        DataGridCell<String>(
          columnName: 'ExpectedCTC',
          value: data['expectedCTC'],
        ),
        DataGridCell<String>(
          columnName: 'Attachment',
          value: data['attachment'],
        ),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),

        /// 🔹 Added here (after Feedback)
        DataGridCell<String>(columnName: 'Stages', value: data['stage']),

        DataGridCell<String>(columnName: 'Status', value: data['status']),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  List<GridColumn> _buildColumns(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 160, label: header('Name')),
      GridColumn(columnName: 'JobId', width: 90, label: header('Job ID')),
      GridColumn(
        columnName: 'RecruitmentId',
        width: 140,
        label: header('Recruitment ID'),
      ),
      GridColumn(
        columnName: 'Phone',
        width: 130,
        label: header('Phone Number'),
      ),
      GridColumn(
        columnName: 'TotalExperience',
        width: 130,
        label: header('Total Experience'),
      ),
      GridColumn(
        columnName: 'RelevantExperience',
        width: 170,
        label: header('Relevant Experience'),
      ),
      GridColumn(
        columnName: 'CurrentCTC',
        width: 110,
        label: header('Current CTC'),
      ),

      GridColumn(
        columnName: 'ExpectedCTC',
        width: 120,
        label: header('Expected CTC'),
      ),
      GridColumn(
        columnName: 'Attachment',
        width: 130,
        label: header('Attachment'),
      ),
      GridColumn(columnName: 'Role', width: 150, label: header('Role')),
      GridColumn(columnName: 'Feedback', width: 120, label: header('Feedback')),
      GridColumn(columnName: 'Stages', width: 150, label: header('Stages')),
      GridColumn(columnName: 'Status', width: 120, label: header('Status')),
      GridColumn(columnName: 'Action', width: 180, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ReusableDataGrid(
      title: 'Rejected Candidates',
      columns: _buildColumns(context),
      rows: _buildRows(),
      totalRows: applicantsData.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        //App Theme Data
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final atsPrimaryColor = Theme.of(context).colorScheme.primary;

        // Always use REAL API DATA
        if (actualDataIndex >= applicantsData.length) {
          return const SizedBox(); // prevents RangeError
        }

        final value = cell.value;
        if (cell.columnName == 'Name') {
          final applicant = applicantsData[actualDataIndex];
          final fullName = applicant['name'] ?? "";
          final email = applicant['email'] ?? "";
          //final color = applicant['avatarColor'] ?? Colors.grey;

          // Get initials from full name
          String getInitials(String name) {
            final parts = name.split(' ');
            if (parts.length == 1) return parts[0][0].toUpperCase();
            return (parts[0][0] + parts[1][0]).toUpperCase();
          }

          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.checkInColor.withValues(
                    alpha: 0.1,
                  ),
                  radius: 12.r,
                  child: KText(
                    text: getInitials(fullName),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.checkInColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: fullName,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          //  color: AppColors.titleColor,
                          textAlign: TextAlign.center,
                        ),
                        KText(
                          text: email,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        //  CV column
        if (cell.columnName == 'Attachment') {
          final applicant = applicantsData[actualDataIndex];
          final cv = applicant['attachment'] ?? "";
          return Row(
            children: [
              Text(cv),
              Spacer(),
              Icon(
                Icons.sim_card_download_outlined,
                size: 16.sp,
                color: theme.textTheme.bodyLarge?.color,
                //AppColors.greyColor,,
              ),
              SizedBox(width: 5.w),
            ],
          );
        }

        ///Stages
        if (cell.columnName == 'Stages') {
          final status = _selectedStages[actualDataIndex];

          // 🔹 Color mapping for container & text
          Color bgColor;
          Color textColor;
          switch (status.toLowerCase()) {
            case 'selected':
              bgColor = AppColors.checkInColor.withValues(alpha: .2);
              textColor = isDark
                  ? AppColors.checkInColorDark
                  : AppColors.checkInColor;
              break;
            case 'rejected':
              bgColor = AppColors.softRed.withValues(alpha: .2);
              textColor = isDark ? AppColors.softRedDark : AppColors.softRed;
              break;
            case 'holding':
              bgColor = Colors.yellow.withValues(alpha: .2);
              textColor = Colors.yellow.shade900;
              break;
            default:
              bgColor = Colors.grey.shade200;
              textColor = Colors.black;
          }

          return Container(
            // height: 20.h,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // color: bgColor, // 🔹 Container background color
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButton<String>(
              value: status,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              dropdownColor: theme
                  .secondaryHeaderColor, // 🔹 White background for dropdown menu
              iconEnabledColor: theme.textTheme.headlineLarge?.color
                  ?.withValues(
                    alpha: 0.5,
                  ), //AppColors.titleColor,, // 🔹  arrow icon
              selectedItemBuilder: (context) {
                // 🔹 This controls how the selected item appears in the container
                return stageOptions.map((stage) {
                  return Center(
                    child: Text(
                      stage,
                      style: TextStyle(
                        color: textColor, // 🔹 Colored text for selected item
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }).toList();
              },
              items: stageOptions.map((stage) {
                return DropdownMenuItem(
                  value: stage,
                  child: Text(
                    stage,
                    style: TextStyle(
                      color: theme
                          .textTheme
                          .headlineLarge
                          ?.color, // 🔹 Black text in dropdown items
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedStages[actualDataIndex] = val;
                    applicantsData[actualDataIndex]['stage'] = val;
                  });
                }
              },
            ),
          );
        }

        /// Status Column
        if (cell.columnName == 'Status') {
          final status = cell.value.toString(); // ⬅️ take current row value
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.checkOutColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.checkOutColor,
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
              ActionButtonWidget(
                color: atsPrimaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              ActionButtonWidget(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
                icon: AppAssetsConstants.deleteIcon,
                onTap: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Candidate'),
                      content: Text('Are you sure you want to delete ?'),
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

                  // if (confirm != true) return;

                  //  final provider = context.read<CandidateActionProvider>();

                  // Show loading
                  // if (context.mounted) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Text("Deleting candidate..."),
                  //       duration: Duration(seconds: 1),
                  //     ),
                  //   );
                  // }
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
}
