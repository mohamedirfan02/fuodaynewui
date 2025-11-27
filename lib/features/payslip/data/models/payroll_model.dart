
import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';

class PayrollModel extends PayrollEntity {
  PayrollModel({
    required String empName,
    required String totalCtc,
    required String totalSalary,
    required String currentMonthSalary,
    required String totalGross,
    required List<PayrollItemModel> payrolls,
  }) : super(
    empName: empName,
    totalCtc: totalCtc,
    totalSalary: totalSalary,
    currentMonthSalary: currentMonthSalary,
    totalGross: totalGross,
    payrolls: payrolls,
  );

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      empName: json['emp_name'] ?? '',
      totalCtc: json['total_ctc'] ?? '',
      totalSalary: json['total_salary'] ?? '',
      currentMonthSalary: json['current_month_salary'] ?? '',
      totalGross: json['total_gross'] ?? '',
      payrolls: (json['payrolls'] as List<dynamic>?)
          ?.map((e) => PayrollItemModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class PayrollItemModel extends PayrollItemEntity {
  PayrollItemModel({
    required int payrollId,
    required String designation,
    required String date,
    required String time,
    required String totalSalary,
    required String gross,
    required String totalDeductions,
    required String basic,
    required String lop,
    required String totalPaidDays,
    required String status,
  }) : super(
    payrollId: payrollId,
    designation: designation,
    date: date,
    time: time,
    totalSalary: totalSalary,
    gross: gross,
    totalDeductions: totalDeductions,
    basic: basic,
    lop: lop,
    totalPaidDays: totalPaidDays,
    status: status,
  );

  factory PayrollItemModel.fromJson(Map<String, dynamic> json) {
    return PayrollItemModel(
      payrollId: json['payroll_id'] ?? 0,
      designation: json['designation'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      totalSalary: json['total_salary'] ?? '',
      gross: json['gross'] ?? '',
      totalDeductions: json['total_deductions'] ?? '',
      basic: json['basic'] ?? '',
      lop: json['lop'] ?? '',
      totalPaidDays: json['total_paid_days'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
