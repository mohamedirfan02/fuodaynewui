import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';

class TotalPayrollModel {
  final String status;
  final String message;
  final int totalCount;
  final List<PayrollEmployeeModel> data;

  TotalPayrollModel({
    required this.status,
    required this.message,
    required this.totalCount,
    required this.data,
  });

  factory TotalPayrollModel.fromJson(Map<String, dynamic> json) {
    return TotalPayrollModel(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      totalCount: int.tryParse(json['total_count']?.toString() ?? '0') ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PayrollEmployeeModel.fromJson(e))
          .toList(),
    );
  }

  TotalPayrollEntity toEntity() => TotalPayrollEntity(
    status: status,
    message: message,
    totalCount: totalCount,
    data: data.map((e) => e.toEntity()).toList(),
  );
}

class PayrollEmployeeModel {
  final String empId;
  final String name;
  final String designation;
  final String dateOfJoining;
  final int year;
  final String? pfAccountNo;
  final String? uan;
  final String? esiNo;
  final String? bankAccountNo;
  final String totalCtc;
  final String monthlySalary;
  final String latestPayslipDate;
  final int totalPaidDays;
  final int lop;
  final double gross;
  final double totalDeductions;
  final String totalSalary;
  final String totalSalaryWord;
  final String status;
  final double incentives;
  final SalaryComponentsModel salaryComponents;

  PayrollEmployeeModel({
    required this.empId,
    required this.name,
    required this.designation,
    required this.dateOfJoining,
    required this.year,
    this.pfAccountNo,
    this.uan,
    this.esiNo,
    this.bankAccountNo,
    required this.totalCtc,
    required this.monthlySalary,
    required this.latestPayslipDate,
    required this.totalPaidDays,
    required this.lop,
    required this.gross,
    required this.totalDeductions,
    required this.totalSalary,
    required this.totalSalaryWord,
    required this.status,
    required this.incentives,
    required this.salaryComponents,
  });

  factory PayrollEmployeeModel.fromJson(Map<String, dynamic> json) {
    return PayrollEmployeeModel(
      empId: json['emp_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      designation: json['designation']?.toString() ?? '',
      dateOfJoining: json['date_of_joining']?.toString() ?? '',
      year: int.tryParse(json['year']?.toString() ?? '0') ?? 0,
      pfAccountNo: json['pf_account_no']?.toString(),
      uan: json['uan']?.toString(),
      esiNo: json['esi_no']?.toString(),
      bankAccountNo: json['bank_account_no']?.toString(),
      totalCtc: json['total_ctc']?.toString() ?? '0',
      monthlySalary: json['monthly_salary']?.toString() ?? '0',
      latestPayslipDate: json['latest_payslip_date']?.toString() ?? '',
      totalPaidDays:
          int.tryParse(json['total_paid_days']?.toString() ?? '0') ?? 0,
      lop: int.tryParse(json['lop']?.toString() ?? '0') ?? 0,
      gross: double.tryParse(json['gross']?.toString() ?? '0') ?? 0.0,
      totalDeductions:
          double.tryParse(json['total_deductions']?.toString() ?? '0') ?? 0.0,
      totalSalary: json['total_salary']?.toString() ?? '0',
      totalSalaryWord: json['total_salary_word']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      incentives: double.tryParse(json['incentives']?.toString() ?? '0') ?? 0.0,
      salaryComponents: SalaryComponentsModel.fromJson(
        json['salary_components'] ?? {},
      ),
    );
  }

  PayrollEmployeeEntity toEntity() => PayrollEmployeeEntity(
    empId: empId,
    name: name,
    designation: designation,
    dateOfJoining: dateOfJoining,
    year: year,
    pfAccountNo: pfAccountNo,
    uan: uan,
    esiNo: esiNo,
    bankAccountNo: bankAccountNo,
    totalCtc: totalCtc,
    monthlySalary: monthlySalary,
    latestPayslipDate: latestPayslipDate,
    totalPaidDays: totalPaidDays,
    lop: lop,
    gross: gross,
    totalDeductions: totalDeductions,
    totalSalary: totalSalary,
    totalSalaryWord: totalSalaryWord,
    status: status,
    incentives: incentives,
    salaryComponents: salaryComponents.toEntity(),
  );
}

class SalaryComponentsModel {
  final List<SalaryComponentModel> earnings;
  final List<SalaryComponentModel> deductions;

  SalaryComponentsModel({required this.earnings, required this.deductions});

  factory SalaryComponentsModel.fromJson(Map<String, dynamic> json) {
    return SalaryComponentsModel(
      earnings: (json['earnings'] as List<dynamic>? ?? [])
          .map((e) => SalaryComponentModel.fromJson(e))
          .toList(),
      deductions: (json['deductions'] as List<dynamic>? ?? [])
          .map((e) => SalaryComponentModel.fromJson(e))
          .toList(),
    );
  }

  SalaryComponentsEntity toEntity() => SalaryComponentsEntity(
    earnings: earnings.map((e) => e.toEntity()).toList(),
    deductions: deductions.map((e) => e.toEntity()).toList(),
  );
}

class SalaryComponentModel {
  final String component;
  final String amount;

  SalaryComponentModel({required this.component, required this.amount});

  factory SalaryComponentModel.fromJson(Map<String, dynamic> json) {
    return SalaryComponentModel(
      component: json['component']?.toString() ?? '',
      amount: json['amount']?.toString() ?? '0',
    );
  }

  SalaryComponentEntity toEntity() =>
      SalaryComponentEntity(component: component, amount: amount);
}
