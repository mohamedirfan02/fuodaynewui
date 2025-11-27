class TotalPayrollEntity {
  final String status;
  final String message;
  final int totalCount;
  final List<PayrollEmployeeEntity> data;

  TotalPayrollEntity({
    required this.status,
    required this.message,
    required this.totalCount,
    required this.data,
  });
}

class PayrollEmployeeEntity {
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
  final SalaryComponentsEntity salaryComponents;

  PayrollEmployeeEntity({
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
}

class SalaryComponentsEntity {
  final List<SalaryComponentEntity> earnings;
  final List<SalaryComponentEntity> deductions;

  SalaryComponentsEntity({required this.earnings, required this.deductions});
}

class SalaryComponentEntity {
  final String component;
  final String amount;

  SalaryComponentEntity({required this.component, required this.amount});
}

extension PayrollEmployeeEntityX on PayrollEmployeeEntity {
  // Get earning amount by component name
  String getEarning(String componentName) {
    try {
      final match = salaryComponents.earnings.firstWhere(
        (e) => e.component == componentName,
      );
      return match.amount;
    } catch (e) {
      return '0'; // fallback if not found
    }
  }

  // Get deduction amount by component name
  String getDeduction(String componentName) {
    try {
      final match = salaryComponents.deductions.firstWhere(
        (e) => e.component == componentName,
      );
      return match.amount;
    } catch (e) {
      return '0';
    }
  }
}
