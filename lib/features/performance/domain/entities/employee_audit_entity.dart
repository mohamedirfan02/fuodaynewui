class EmployeeAuditEntity {
  final String? employeeName;
  final String? empId;
  final String? department;
  final String? designation;
  final String? reportingManager;
  final String? dateOfJoining;
  final String? workingMode;
  final AttendanceSummaryEntity? attendanceSummary;
  final double? attendancePercentage;
  final PayrollEntity? payroll;
  final List<AuditPerformanceEntity>? performance;

  const EmployeeAuditEntity({
    this.employeeName,
    this.empId,
    this.department,
    this.designation,
    this.reportingManager,
    this.dateOfJoining,
    this.workingMode,
    this.attendanceSummary,
    this.attendancePercentage,
    this.payroll,
    this.performance,
  });
}

class AttendanceSummaryEntity {
  final int? present;
  final int? leave;
  final int? lop;

  const AttendanceSummaryEntity({this.present, this.leave, this.lop});
}

class PayrollEntity {
  final double? ctc;
  final double? totalSalary;
  final String? month;

  const PayrollEntity({this.ctc, this.totalSalary, this.month});
}

class AuditPerformanceEntity {
  final int? id;
  final int? webUserId;
  final String? empName;
  final String? empId;
  final DateTime? date;
  final String? description;
  final String? assignedBy;
  final int? assignedById;
  final String? assignedTo;
  final int? assignedToId;
  final String? project;
  final String? priority;
  final String? status;
  final String? progressNote;
  final DateTime? deadline;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AuditPerformanceEntity({
    this.id,
    this.webUserId,
    this.empName,
    this.empId,
    this.date,
    this.description,
    this.assignedBy,
    this.assignedById,
    this.assignedTo,
    this.assignedToId,
    this.project,
    this.priority,
    this.status,
    this.progressNote,
    this.deadline,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });
}
