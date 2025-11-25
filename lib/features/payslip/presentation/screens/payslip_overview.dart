import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/payslip/presentation/Provider/payroll_overview_provider.dart';
import 'package:provider/provider.dart';

class PayslipOverview extends StatefulWidget {
  const PayslipOverview({super.key});

  @override
  State<PayslipOverview> createState() => _PayslipOverviewState();
}

class _PayslipOverviewState extends State<PayslipOverview> {
  @override
  void initState() {
    super.initState();
    // Fetch payroll overview when widget is created
    Future.microtask(
      () => context.read<PayrollOverviewProvider>().fetchPayrollOverview(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    final payrollProvider = context.watch<PayrollOverviewProvider>();

    if (payrollProvider.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: theme.primaryColor),
      );
    }

    if (payrollProvider.errorMessage != null) {
      return Center(
        child: Text(
          payrollProvider.errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final payroll = payrollProvider.payrollOverview;
    if (payroll == null) {
      return const Center(child: Text("No payroll data available"));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KVerticalSpacer(height: 20),

          // Employee Name
          KAuthTextFormField(
            label: "Employee Name",
            hintText: payroll.employeeDetails.name,
            isReadOnly: true,
            suffixIcon: Icons.person_outline,
          ),
          SizedBox(height: 8.h),
          // Employee ID
          KAuthTextFormField(
            label: "Employee ID",
            hintText: payroll.employeeDetails.empId,
            isReadOnly: true,
            suffixIcon: Icons.badge_outlined,
          ),
          SizedBox(height: 8.h),

          // Designation
          KAuthTextFormField(
            label: "Designation",
            hintText: payroll.employeeDetails.designation,
            isReadOnly: true,
            suffixIcon: Icons.school_outlined,
          ),
          SizedBox(height: 8.h),

          // Date of Joining
          KAuthTextFormField(
            label: "Date of Joining",
            hintText: payroll.employeeDetails.dateOfJoining,
            isReadOnly: true,
            suffixIcon: Icons.calendar_month_outlined,
          ),
          SizedBox(height: 8.h),

          // Pay Period (Month from payslip) - Handle null
          KAuthTextFormField(
            label: "Pay Period",
            hintText: payroll.payslip.month ?? "Not Available",
            isReadOnly: true,
            suffixIcon: Icons.calendar_month_outlined,
          ),
          SizedBox(height: 8.h),

          // Pay Date - Handle null
          KAuthTextFormField(
            label: "Pay Date",
            hintText: payroll.payslip.date ?? "Not Available",
            isReadOnly: true,
            suffixIcon: Icons.calendar_month_outlined,
          ),
          SizedBox(height: 8.h),

          // PF Account Number
          KAuthTextFormField(
            label: "PF A/c Number",
            hintText: payroll.onboardingDetails.pfAccountNo ?? "-",
            isReadOnly: true,
            suffixIcon: Icons.payment,
          ),
          SizedBox(height: 8.h),

          // UAN Number
          KAuthTextFormField(
            label: "UAN Number",
            hintText: payroll.onboardingDetails.uan ?? "-",
            isReadOnly: true,
            suffixIcon: Icons.payment,
          ),
          SizedBox(height: 8.h),

          // ESI Number
          KAuthTextFormField(
            label: "ESI Number",
            hintText: payroll.onboardingDetails.esiNo ?? "-",
            isReadOnly: true,
            suffixIcon: Icons.payment,
          ),

          SizedBox(height: 20.h),

          // Earnings Section styled like Total Payable
          KText(text: "Earnings", fontWeight: FontWeight.w600, fontSize: 14.sp),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                // Month row - Handle null
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: "Month",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    KText(
                      text: payroll.payslip.month ?? "Not Available",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Each earning component and amount
                ...payroll.salaryComponents["Earnings"]!.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: entry.key,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                        KText(
                          text: entry.value.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // Show placeholder if no earnings
                if (payroll.salaryComponents["Earnings"]!.isEmpty)
                  KText(
                    text: "No earnings",
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          // Deductions Section styled like Total Payable
          KText(
            text: "Deductions",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),

          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                // Month row - Handle null
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: "Month",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    KText(
                      text: payroll.payslip.month ?? "Not Available",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Now show each deduction component and amount
                ...payroll.salaryComponents["Deductions"]!.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: entry.key,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                        KText(
                          text: entry.value.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // If no deductions, show a placeholder row
                if (payroll.salaryComponents["Deductions"]!.isEmpty)
                  KText(
                    text: "No deductions",
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          // Total Payable Section
          KText(
            text: "Total Payable",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: "Month",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    KText(
                      text: payroll.payslip.month ?? "Not Available",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: "Total Salary",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    KText(
                      text: payroll.payslip.totalSalary.toString(),
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: "In Words",
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    KText(
                      text: payroll.payslip.totalSalaryWord,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
