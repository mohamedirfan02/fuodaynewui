import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';

import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_candidates_datatable.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OnboardingTab extends StatefulWidget {
  const OnboardingTab({super.key});

  @override
  State<OnboardingTab> createState() => _OnboardingTabState();
}

class _OnboardingTabState extends State<OnboardingTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample data for candidates
  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'jobId': '1001',
      'bgv': 'Completed',
      'mailSend': 'Yes',
      'role': 'Intern',
      'contact': '89034 56787',
      'offerDate': '12-10-2025',
      'offer': 'Accepted',
      'atsScore': '85%',
      'overallScore': '90%',
      'closedCtc': '4.5 LPA',
      'noticePeriod': '30 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Irfan Khan',
      'jobId': '1002',
      'bgv': 'Pending',
      'mailSend': 'No',
      'role': 'Junior Developer',
      'contact': '98001 22254',
      'offerDate': '14-10-2025',
      'offer': 'Pending',
      'atsScore': '30%',
      'overallScore': '88%',
      'closedCtc': '6 LPA',
      'noticePeriod': '60 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Mohamed Yousuf',
      'jobId': '1003',
      'bgv': 'Completed',
      'mailSend': 'Yes',
      'role': 'Flutter Developer',
      'contact': '90012 34677',
      'offerDate': '16-10-2025',
      'offer': 'Accepted',
      'atsScore': '92%',
      'overallScore': '95%',
      'closedCtc': '8 LPA',
      'noticePeriod': '45 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Priya Sharma',
      'jobId': '1004',
      'bgv': 'Rejected',
      'mailSend': 'No',
      'role': 'UI/UX Designer',
      'contact': '89112 55437',
      'offerDate': '18-10-2025',
      'offer': 'Not Selected',
      'atsScore': '50%',
      'overallScore': '80%',
      'closedCtc': '5.2 LPA',
      'noticePeriod': '15 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Sanjay Patel',
      'jobId': '1005',
      'bgv': 'Pending',
      'mailSend': 'Yes',
      'role': 'Backend Developer',
      'contact': '91223 56787',
      'offerDate': '20-10-2025',
      'offer': 'Pending',
      'atsScore': '84%',
      'overallScore': '86%',
      'closedCtc': '7.5 LPA',
      'noticePeriod': '30 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Neha Verma',
      'jobId': '1006',
      'bgv': 'Completed',
      'mailSend': 'Yes',
      'role': 'HR Executive',
      'contact': '70023 22114',
      'offerDate': '21-10-2025',
      'offer': 'Accepted',
      'atsScore': '45%',
      'overallScore': '84%',
      'closedCtc': '4 LPA',
      'noticePeriod': '0 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Arun Raj',
      'jobId': '1007',
      'bgv': 'Completed',
      'mailSend': 'No',
      'role': 'Data Engineer',
      'contact': '78745 22221',
      'offerDate': '21-10-2025',
      'offer': 'Negotiating',
      'atsScore': '87%',
      'overallScore': '89%',
      'closedCtc': '13 LPA',
      'noticePeriod': '90 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Keerthana',
      'jobId': '1008',
      'bgv': 'Pending',
      'mailSend': 'No',
      'role': 'Business Analyst',
      'contact': '94455 32100',
      'offerDate': '22-10-2025',
      'offer': 'Pending',
      'atsScore': '76%',
      'overallScore': '79%',
      'closedCtc': '6.2 LPA',
      'noticePeriod': '60 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Sharan',
      'jobId': '1009',
      'bgv': 'Completed',
      'mailSend': 'Yes',
      'role': 'React Developer',
      'contact': '95332 99887',
      'offerDate': '23-10-2025',
      'offer': 'Accepted',
      'atsScore': '91%',
      'overallScore': '93%',
      'closedCtc': '7.8 LPA',
      'noticePeriod': '30 Days',
      'action': 'View Profile',
    },
    {
      'name': 'Harini',
      'jobId': '1010',
      'bgv': 'Rejected',
      'mailSend': 'Yes',
      'role': 'QA Tester',
      'contact': '90022 11124',
      'offerDate': '24-10-2025',
      'offer': 'Not Selected',
      'atsScore': '74%',
      'overallScore': '77%',
      'closedCtc': '4.8 LPA',
      'noticePeriod': '15 Days',
      'action': 'View Profile',
    },
  ];

  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key;
    var data = entry.value;
    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobID', value: data['jobId']),
        DataGridCell<String>(columnName: 'BGV', value: data['bgv']),
        DataGridCell<String>(columnName: 'MailSend', value: data['mailSend']),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(columnName: 'Contact', value: data['contact']),
        DataGridCell<String>(columnName: 'OfferDate', value: data['offerDate']),
        DataGridCell<String>(columnName: 'Offer', value: data['offer']),
        DataGridCell<String>(columnName: 'ATSScore', value: data['atsScore']),
        DataGridCell<String>(
          columnName: 'OverallScore',
          value: data['overallScore'],
        ),
        DataGridCell<String>(columnName: 'ClosedCTC', value: data['closedCtc']),
        DataGridCell<String>(
          columnName: 'NoticePeriod',
          value: data['noticePeriod'],
        ),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
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
      GridColumn(columnName: 'SNo', width: 70, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 160, label: header('Name')),
      GridColumn(columnName: 'JobID', width: 100, label: header('Job ID')),
      GridColumn(columnName: 'BGV', width: 110, label: header('BGV')),
      GridColumn(
        columnName: 'MailSend',
        width: 110,
        label: header('Mail Send'),
      ),
      GridColumn(columnName: 'Role', width: 150, label: header('Role')),
      GridColumn(columnName: 'Contact', width: 130, label: header('Contact')),
      GridColumn(
        columnName: 'OfferDate',
        width: 140,
        label: header('Offer Date'),
      ),
      GridColumn(columnName: 'Offer', width: 130, label: header('Offer')),
      GridColumn(
        columnName: 'ATSScore',
        width: 120,
        label: header('ATS Score'),
      ),
      GridColumn(
        columnName: 'OverallScore',
        width: 150,
        label: header('Test Overall Score'),
      ),
      GridColumn(
        columnName: 'ClosedCTC',
        width: 140,
        label: header('Closed CTC'),
      ),
      GridColumn(
        columnName: 'NoticePeriod',
        width: 130,
        label: header('Notice Period'),
      ),
      GridColumn(columnName: 'Action', width: 140, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rows = _buildRows();
    final columns = _buildColumns();

    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.atsUserIcon,
        'title': 'Total Employees',
        'numberOfCount': "13,540",
      },
      {
        'title': 'Awaiting Employment',
        'numberOfCount': "708",
        'icon': AppAssetsConstants.timerIcon,
      },
      {
        'title': 'Ofer Acceptance Rate',
        'numberOfCount': "958",
        'icon': AppAssetsConstants.beatsIcon,
      },
      {
        'title': 'Conversion Rate',
        'numberOfCount': "1,504",
        'icon': AppAssetsConstants.conversionIcon,
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.cardColor, //ATS Background Color
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppResponsive.responsiveCrossAxisCount(
                      context,
                    ),
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
                SizedBox(height: 14.h),
                Container(
                  //padding: EdgeInsets.all(18.47.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color: theme.secondaryHeaderColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          left: 18.47.w,
                          right: 18.47.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: KText(
                                text: "Onboarding Candidate List",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                //color: AppColors.titleColor,
                              ),
                            ),
                            Expanded(
                              child: KAtsGlowButton(
                                width: 110,
                                text: "Filter",
                                textColor:
                                    theme.textTheme.bodyLarge?.color ??
                                    AppColors.greyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                icon: Icon(
                                  Icons.filter_alt_outlined,
                                  size: 20,
                                  color:
                                      theme.textTheme.bodyLarge?.color ??
                                      AppColors.greyColor,
                                ),
                                onPressed: () {
                                  print("Filter button tapped");
                                },
                                backgroundColor: theme.secondaryHeaderColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      KVerticalSpacer(height: 16.h),

                      ///New Data Table
                      newDatatable(columns, rows, applicantsData, context),
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
}

/// Data Table Widget
ReusableDataGrid newDatatable(
  List<GridColumn> columns,
  List<DataGridRow> rows,
  List<Map<String, dynamic>> applicantsData,
  BuildContext context,
) {
  return ReusableDataGrid(
    title: 'Applicants',
    columns: columns,
    rows: rows,
    allowSorting: false,
    totalRows: rows.length,
    initialRowsPerPage: 5,
    cellBuilder: (cell, rowIndex, actualDataIndex) {
      //App Theme Data
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;
      //final atsPrimaryColor = Theme.of(context).colorScheme.primary;

      //App Theme Data
      // final isDark = theme.brightness == Brightness.dark;
      // final atsPrimaryColor = Theme.of(context).colorScheme.primary;

      // Always use REAL API DATA
      if (actualDataIndex >= applicantsData.length) {
        return const SizedBox(); // prevents RangeError
      }
      final value = cell.value;

      ///ATS Score
      if (cell.columnName == 'ATSScore') {
        final status = cell.value.toString(); // ⬅️ take current row value

        // Extract numeric value from status (e.g., "89%" -> 89)
        final numericScore = int.tryParse(status.replaceAll('%', '')) ?? 0;

        // Determine color based on score range
        Color backgroundColor;
        Color textColor;

        if (numericScore >= 1 && numericScore <= 39) {
          // Red for 1-39
          backgroundColor = Colors.red.withValues(alpha: 0.1);
          textColor = Colors.red;
        } else if (numericScore >= 40 && numericScore <= 59) {
          // Yellow for 40-59
          backgroundColor = Colors.orange.withValues(alpha: 0.1);
          textColor = Colors.orange;
        } else if (numericScore >= 60 && numericScore <= 100) {
          // Green for 60-100
          backgroundColor = Colors.green.withValues(alpha: 0.1);
          textColor = Colors.green;
        } else {
          // Default color if score is out of range
          backgroundColor = Colors.grey.withValues(alpha: 0.1);
          textColor = Colors.grey;
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
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
              color: AppColors.checkInColor.withValues(alpha: 0.8),
              icon: AppAssetsConstants.checkIcon,
              onTap: () {},
            ),
            SizedBox(width: 8.w),
            ActionButtonWidget(
              color: isDark
                  ? AppColors.checkOutColorDark
                  : AppColors.checkOutColor,
              icon: AppAssetsConstants.cancelIcon,
              onTap: () async {
                // Show confirmation dialog
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
