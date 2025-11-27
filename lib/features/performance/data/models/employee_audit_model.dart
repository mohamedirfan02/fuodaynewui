/*
// employee_audit_model.dart
import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';

class EmployeeAuditModel extends EmployeeAuditEntity {
  const EmployeeAuditModel({
    super.employeeName,
    super.empId,
    super.department,
    super.designation,
    super.reportingManager,
    super.dateOfJoining,
    super.workingMode,
    super.attendanceSummary,
    super.attendancePercentage,
    super.payroll,
    super.performance,
  });

  factory EmployeeAuditModel.fromJson(Map<String, dynamic> json) {
    return EmployeeAuditModel(
      employeeName: json['employee_name'],
      empId: json['emp_id'],
      department: json['department'],
      designation: json['designation'],
      reportingManager: json['reporting_manager'],
      dateOfJoining: json['date_of_joining'],
      workingMode: json['working_mode'],
      attendanceSummary: json['attendance_summary'] != null
          ? AttendanceSummaryModel.fromJson(json['attendance_summary'])
          : null,
      attendancePercentage: (json['attendance_percentage'] as num?)?.toDouble(),
      payroll: json['payroll'] != null
          ? PayrollModel.fromJson(json['payroll'])
          : null,
      performance: (json['performance'] as List<dynamic>?)
          ?.map((e) => AuditPerformanceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'employee_name': employeeName,
    'emp_id': empId,
    'department': department,
    'designation': designation,
    'reporting_manager': reportingManager,
    'date_of_joining': dateOfJoining,
    'working_mode': workingMode,
    'attendance_summary': (attendanceSummary as AttendanceSummaryModel?)
        ?.toJson(),
    'attendance_percentage': attendancePercentage,
    'payroll': (payroll as PayrollModel?)?.toJson(),
    'performance': performance
        ?.map((e) => (e as AuditPerformanceModel).toJson())
        .toList(),
  };
}

class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({super.present, super.leave, super.lop});

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      present: json['present'] is Int?json['present']:,
      leave: json['leave'],
      lop: json['lop'],
    );
  }

  Map<String, dynamic> toJson() => {
    'present': present,
    'leave': leave,
    'lop': lop,
  };
}

class PayrollModel extends PayrollEntity {
  const PayrollModel({super.ctc, super.totalSalary, super.month});

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      ctc: (json['ctc'] as num?)?.toDouble(),
      totalSalary: (json['total_salary'] as num?)?.toDouble(),
      month: json['month'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ctc': ctc,
    'total_salary': totalSalary,
    'month': month,
  };
}

class AuditPerformanceModel extends AuditPerformanceEntity {
  const AuditPerformanceModel({
    super.id,
    super.webUserId,
    super.empName,
    super.empId,
    super.date,
    super.description,
    super.assignedBy,
    super.assignedById,
    super.assignedTo,
    super.assignedToId,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.comment,
    super.createdAt,
    super.updatedAt,
  });

  factory AuditPerformanceModel.fromJson(Map<String, dynamic> json) {
    return AuditPerformanceModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      description: json['description'],
      assignedBy: json['assigned_by'],
      assignedById: json['assigned_by_id'],
      assignedTo: json['assigned_to'],
      assignedToId: json['assigned_to_id'],
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'date': date?.toIso8601String(),
    'description': description,
    'assigned_by': assignedBy,
    'assigned_by_id': assignedById,
    'assigned_to': assignedTo,
    'assigned_to_id': assignedToId,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
*/

// employee_audit_model.dart
import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';

class EmployeeAuditModel extends EmployeeAuditEntity {
  const EmployeeAuditModel({
    super.employeeName,
    super.empId,
    super.department,
    super.designation,
    super.reportingManager,
    super.dateOfJoining,
    super.workingMode,
    super.attendanceSummary,
    super.attendancePercentage,
    super.payroll,
    super.performance,
  });

  factory EmployeeAuditModel.fromJson(Map<String, dynamic> json) {
    return EmployeeAuditModel(
      employeeName: json['employee_name'],
      empId: json['emp_id'],
      department: json['department'],
      designation: json['designation'],
      reportingManager: json['reporting_manager'],
      dateOfJoining: json['date_of_joining'],
      workingMode: json['working_mode'],
      attendanceSummary: json['attendance_summary'] != null
          ? AttendanceSummaryModel.fromJson(json['attendance_summary'])
          : null,
      attendancePercentage: (json['attendance_percentage'] as num?)?.toDouble(),
      payroll: json['payroll'] != null
          ? PayrollModel.fromJson(json['payroll'])
          : null,
      performance: (json['performance'] as List<dynamic>?)
          ?.map((e) => AuditPerformanceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'employee_name': employeeName,
    'emp_id': empId,
    'department': department,
    'designation': designation,
    'reporting_manager': reportingManager,
    'date_of_joining': dateOfJoining,
    'working_mode': workingMode,
    'attendance_summary': (attendanceSummary as AttendanceSummaryModel?)
        ?.toJson(),
    'attendance_percentage': attendancePercentage,
    'payroll': (payroll as PayrollModel?)?.toJson(),
    'performance': performance
        ?.map((e) => (e as AuditPerformanceModel).toJson())
        .toList(),
  };
}

class AttendanceSummaryModel extends AttendanceSummaryEntity {
  const AttendanceSummaryModel({super.present, super.leave, super.lop});

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      //   Safe int parsing
      present: json['present'] is int
          ? json['present']
          : int.tryParse(json['present']?.toString() ?? ''),
      //   Safe int parsing
      leave: json['leave'] is int
          ? json['leave']
          : int.tryParse(json['leave']?.toString() ?? ''),
      //   Safe int parsing
      lop: json['lop'] is int
          ? json['lop']
          : int.tryParse(json['lop']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'present': present,
    'leave': leave,
    'lop': lop,
  };
}

class PayrollModel extends PayrollEntity {
  const PayrollModel({super.ctc, super.totalSalary, super.month});

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      ctc: (json['ctc'] as num?)?.toDouble(),
      totalSalary: (json['total_salary'] as num?)?.toDouble(),
      month: json['month'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ctc': ctc,
    'total_salary': totalSalary,
    'month': month,
  };
}

class AuditPerformanceModel extends AuditPerformanceEntity {
  const AuditPerformanceModel({
    super.id,
    super.webUserId,
    super.empName,
    super.empId,
    super.date,
    super.description,
    super.assignedBy,
    super.assignedById,
    super.assignedTo,
    super.assignedToId,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.comment,
    super.createdAt,
    super.updatedAt,
  });

  factory AuditPerformanceModel.fromJson(Map<String, dynamic> json) {
    return AuditPerformanceModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      //   Safe int parsing
      webUserId: json['web_user_id'] is int
          ? json['web_user_id']
          : int.tryParse(json['web_user_id']?.toString() ?? ''),
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      description: json['description'],
      assignedBy: json['assigned_by'],
      //   Safe int parsing
      assignedById: json['assigned_by_id'] is int
          ? json['assigned_by_id']
          : int.tryParse(json['assigned_by_id']?.toString() ?? ''),
      assignedTo: json['assigned_to'],
      //   Safe int parsing
      assignedToId: json['assigned_to_id'] is int
          ? json['assigned_to_id']
          : int.tryParse(json['assigned_to_id']?.toString() ?? ''),
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'date': date?.toIso8601String(),
    'description': description,
    'assigned_by': assignedBy,
    'assigned_by_id': assignedById,
    'assigned_to': assignedTo,
    'assigned_to_id': assignedToId,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
