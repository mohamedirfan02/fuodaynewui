class PayrollEntity {
  final String empName;
  final String totalCtc;
  final String totalSalary;
  final String currentMonthSalary;
  final String totalGross;
  final List<PayrollItemEntity> payrolls;

  PayrollEntity({
    required this.empName,
    required this.totalCtc,
    required this.totalSalary,
    required this.currentMonthSalary,
    required this.totalGross,
    required this.payrolls,
  });
}

class PayrollItemEntity {
  final int payrollId;
  final String designation;
  final String date;
  final String time;
  final String totalSalary;
  final String gross;
  final String totalDeductions;
  final String basic;
  final String lop;
  final String totalPaidDays;
  final String status;

  PayrollItemEntity({
    required this.payrollId,
    required this.designation,
    required this.date,
    required this.time,
    required this.totalSalary,
    required this.gross,
    required this.totalDeductions,
    required this.basic,
    required this.lop,
    required this.totalPaidDays,
    required this.status,
  });
}
