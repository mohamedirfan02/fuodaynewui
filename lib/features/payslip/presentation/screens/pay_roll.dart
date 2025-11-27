import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_line_chart.dart';
import 'package:fuoday/features/payslip/presentation/widgets/pay_slip_card.dart';
import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';
import 'package:fuoday/features/payslip/domain/usecase/get_payroll_usecase.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';

class PayRoll extends StatefulWidget {
  const PayRoll({super.key});

  @override
  State<PayRoll> createState() => _PayRollState();
}

class _PayRollState extends State<PayRoll> {
  late GetPayrollUseCase getPayrollUseCase;
  PayrollEntity? payroll;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getPayrollUseCase = getIt<GetPayrollUseCase>();
    _loadPayroll();
  }

  Future<void> _loadPayroll() async {
    try {
      final webUserId = getIt<HiveStorageService>()
          .employeeDetails?['web_user_id']
          ?.toString();

      if (webUserId == null) {
        setState(() {
          errorMessage = 'User ID not found in Hive';
          isLoading = false;
        });
        return;
      }

      final data = await getPayrollUseCase(int.parse(webUserId));

      setState(() {
        payroll = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // Show loading indicator
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error message
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.w,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            ),
            KVerticalSpacer(height: 16.h),
            KText(
              text: errorMessage!,
              fontSize: 14.sp,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      );
    }

    // Show no data message
    if (payroll == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48.w,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            ),
            KVerticalSpacer(height: 16.h),
            KText(
              text: "No payroll data found",
              fontSize: 14.sp,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      );
    }

    // Prepare data for table
    final columns = [
      'Months',
      'date',
      'gross',
      'total deductions',
      'total salary',
      'status',
    ];

    final data = payroll!.payrolls.map((item) {
      return {
        'Months': item.date.substring(5, 7),
        'date': item.date,
        'gross': item.gross,
        'total deductions': item.totalDeductions,
        'total salary': item.totalSalary,
        'status': item.status,
      };
    }).toList();

    // Sample attendance data for chart (you can replace with real data)
    final attendanceData = [
      20.0,
      22.0,
      18.0,
      24.0,
      21.0,
      25.0,
      19.0,
      22.5,
      20.0,
      23.0,
      21.0,
      24.0,
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 20.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KVerticalSpacer(height: 20.h),

          // PaySlip Cards with real data
          Row(
            spacing: 8.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pay Roll Cost
              PaySlipCard(
                iconData: Icons.credit_card,
                cardTitle: "Total pay per year",
                amount: payroll!.totalCtc,
              ),

              // Total Pay per year
              PaySlipCard(
                iconData: Icons.person,
                cardTitle: "Pay Roll Cost",
                amount: payroll!.totalSalary,
              ),
            ],
          ),

          // Chart
          SizedBox(
            height: 340.h,
            child: AttendanceLineChart(
              attendanceValues: attendanceData,
              months: months,
            ),
          ),

          KVerticalSpacer(height: 20.h),

          // Deduction Section
          KText(
            text: "Deduction",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          KVerticalSpacer(height: 20.h),

          // Coming soon text
          Align(
            alignment: Alignment.center,
            child: KText(
              text: "Coming soon",
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              fontSize: 14.sp,
            ),
          ),

          KVerticalSpacer(height: 60.h),

          // Data Table with real payroll data
          SizedBox(
            height: 200.h,
            child: KDataTable(columnTitles: columns, rowData: data),
          ),

          KVerticalSpacer(height: 20.h),
        ],
      ),
    );
  }
}
