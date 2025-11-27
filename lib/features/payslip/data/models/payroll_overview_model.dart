import 'package:fuoday/features/payslip/domain/entities/payroll_overview_entity.dart';

class PayrollOverviewModel extends PayrollOverviewEntity {
  PayrollOverviewModel({
    required PayslipEntity payslip,
    required Map<String, Map<String, num>> salaryComponents,
    required EmployeeDetailsEntity employeeDetails,
    required OnboardingDetailsEntity onboardingDetails,
  }) : super(
    payslip: payslip,
    salaryComponents: salaryComponents,
    employeeDetails: employeeDetails,
    onboardingDetails: onboardingDetails,
  );

  factory PayrollOverviewModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    num _parseNum(dynamic value) {
      if (value is num) return value;
      if (value is String) return num.tryParse(value) ?? 0;
      return 0;
    }

    // Parses components if input is a Map<String, dynamic>
    Map<String, num> parseComponentsFromMap(Map<String, dynamic> map) {
      final result = <String, num>{};
      map.forEach((key, value) {
        result[key] = _parseNum(value);
      });
      return result;
    }

    // Parses components if input is a List<dynamic> (possibly empty)
    Map<String, num> parseComponentsFromList(List<dynamic> list) {
      final result = <String, num>{};
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          final key = item['component'] as String? ?? '';
          final value = item['amount'];
          if (key.isNotEmpty) {
            result[key] = _parseNum(value);
          }
        }
      }
      return result;
    }

    // General parser that detects input type
    Map<String, num> parseComponents(dynamic input) {
      if (input is Map<String, dynamic>) {
        return parseComponentsFromMap(input);
      } else if (input is List<dynamic>) {
        return parseComponentsFromList(input);
      }
      return {};
    }

    return PayrollOverviewModel(
      payslip: PayslipEntity(
        month: data['payslip']['month'],
        basic: _parseNum(data['payslip']['basic']),
        overtime: _parseNum(data['payslip']['overtime']),
        totalPaidDays: data['payslip']['total_paid_days'],
        lop: _parseNum(data['payslip']['lop']),
        gross: _parseNum(data['payslip']['gross']),
        totalDeductions: _parseNum(data['payslip']['total_deductions']),
        totalSalary: _parseNum(data['payslip']['total_salary']),
        totalSalaryWord: data['payslip']['total_salary_word'],
        status: data['payslip']['status'],
        date: data['payslip']['date'],
        companyName: data['payslip']['company_name'],
        logo: data['payslip']['logo'],
      ),
      salaryComponents: {
        'Earnings': parseComponents(data['salary_components']['Earnings']),
        'Deductions': parseComponents(data['salary_components']['Deductions']),
      },
      employeeDetails: EmployeeDetailsEntity(
        name: data['employee_details']['name'],
        designation: data['employee_details']['designation'],
        empId: data['employee_details']['emp_id'],
        dateOfJoining: data['employee_details']['date_of_joining'],
        year: data['employee_details']['year'],
      ),
      onboardingDetails: OnboardingDetailsEntity(
        pfAccountNo: data['onboarding_details']['pf_account_no'],
        uan: data['onboarding_details']['uan'],
        esiNo: data['onboarding_details']['esi_no'],
        bankAccountNo: data['onboarding_details']['bank_account_no'],
      ),
    );
  }

}
