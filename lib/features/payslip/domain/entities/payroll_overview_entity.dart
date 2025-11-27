class PayrollOverviewEntity {
  final PayslipEntity payslip;
  final Map<String, Map<String, num>> salaryComponents; // Earnings/Deductions
  final EmployeeDetailsEntity employeeDetails;
  final OnboardingDetailsEntity onboardingDetails;

  PayrollOverviewEntity({
    required this.payslip,
    required this.salaryComponents,
    required this.employeeDetails,
    required this.onboardingDetails,
  });
}

class PayslipEntity {
  final String? month; // Made nullable
  final num basic; // Changed to num (API returns int)
  final num overtime;
  final String? totalPaidDays; // Made nullable
  final num lop;
  final num gross; // Changed to num (API returns int)
  final num totalDeductions; // Changed to num (API returns int)
  final num totalSalary; // Changed to num (API returns int)
  final String totalSalaryWord;
  final String status;
  final String? date; // Made nullable
  final String companyName;
  final String logo;

  PayslipEntity({
    this.month, // No longer required
    required this.basic,
    required this.overtime,
    this.totalPaidDays, // No longer required
    required this.lop,
    required this.gross,
    required this.totalDeductions,
    required this.totalSalary,
    required this.totalSalaryWord,
    required this.status,
    this.date, // No longer required
    required this.companyName,
    required this.logo,
  });
}

class EmployeeDetailsEntity {
  final String name;
  final String designation;
  final String empId;
  final String dateOfJoining;
  final String year;

  EmployeeDetailsEntity({
    required this.name,
    required this.designation,
    required this.empId,
    required this.dateOfJoining,
    required this.year,
  });
}

class OnboardingDetailsEntity {
  final String? pfAccountNo;
  final String? uan;
  final String? esiNo;
  final String? bankAccountNo;

  OnboardingDetailsEntity({
    this.pfAccountNo,
    this.uan,
    this.esiNo,
    this.bankAccountNo,
  });
}