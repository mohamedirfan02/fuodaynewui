//
// import 'package:equatable/equatable.dart';
//
// class HROverviewEntity extends Equatable {
//   final HRStats stats;
//   final List<RecentEmployee> recentEmployees;
//   final List<OpenPosition> openPositions;
//
//   const HROverviewEntity({
//     required this.stats,
//     required this.recentEmployees,
//     required this.openPositions,
//   });
//
//   @override
//   List<Object?> get props => [stats, recentEmployees, openPositions];
// }
//
// class HRStats extends Equatable {
//   final int totalEmployees;
//   final int totalLeaveRequests;
//   final int totalPermissions;
//   final int totalAttendance;
//   final int totalLateArrival;
//   final int totalEvent;
//   final int totalAudits;
//   final int totalRegulationApproval;
//
//   const HRStats({
//     required this.totalEmployees,
//     required this.totalLeaveRequests,
//     required this.totalPermissions,
//     required this.totalAttendance,
//     required this.totalLateArrival,
//     required this.totalEvent,
//     required this.totalAudits,
//     required this.totalRegulationApproval,
//   });
//
//   @override
//   List<Object?> get props => [
//     totalEmployees,
//     totalLeaveRequests,
//     totalPermissions,
//     totalAttendance,
//     totalLateArrival,
//     totalEvent,
//     totalAudits,
//     totalRegulationApproval
//   ];
// }
//
// class RecentEmployee extends Equatable {
//   final int id;
//   final String name;
//   final String role;
//   final String empId;
//   final String? profilePhoto;
//   final String dateOfJoining;
//
//   const RecentEmployee({
//     required this.id,
//     required this.name,
//     required this.role,
//     required this.empId,
//     required this.profilePhoto,
//     required this.dateOfJoining,
//   });
//
//   @override
//   List<Object?> get props => [id, name, role, empId, profilePhoto, dateOfJoining];
// }
//
// class OpenPosition extends Equatable {
//   final String title;
//   final String postedAt;
//   final String noOfOpenings;
//
//   const OpenPosition({
//     required this.title,
//     required this.postedAt,
//     required this.noOfOpenings,
//   });
//
//   @override
//   List<Object?> get props => [title, postedAt, noOfOpenings];
// }
import 'package:equatable/equatable.dart';

class HROverviewEntity extends Equatable {
  final HRStats stats;
  final List<RecentEmployee> recentEmployees;
  final List<OpenPosition> openPositions;
  final List<PermissionData> permissions; // ✅ Added

  const HROverviewEntity({
    required this.stats,
    required this.recentEmployees,
    required this.openPositions,
    required this.permissions, // ✅ Added
  });

  @override
  List<Object?> get props => [
    stats,
    recentEmployees,
    openPositions,
    permissions,
  ];
}

class HRStats extends Equatable {
  final int totalEmployees;
  final int totalLeaveRequests;
  final int totalPermissions;
  final int totalAttendance;
  final int totalLateArrival;
  final int totalEvent;
  final int totalAudits;
  final int totalRegulationApproval;

  const HRStats({
    required this.totalEmployees,
    required this.totalLeaveRequests,
    required this.totalPermissions,
    required this.totalAttendance,
    required this.totalLateArrival,
    required this.totalEvent,
    required this.totalAudits,
    required this.totalRegulationApproval,
  });

  @override
  List<Object?> get props => [
    totalEmployees,
    totalLeaveRequests,
    totalPermissions,
    totalAttendance,
    totalLateArrival,
    totalEvent,
    totalAudits,
    totalRegulationApproval,
  ];
}

class RecentEmployee extends Equatable {
  final int id;
  final String name;
  final String role;
  final String empId;
  final String? profilePhoto;
  final String dateOfJoining;

  const RecentEmployee({
    required this.id,
    required this.name,
    required this.role,
    required this.empId,
    required this.profilePhoto,
    required this.dateOfJoining,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    role,
    empId,
    profilePhoto,
    dateOfJoining,
  ];
}

class OpenPosition extends Equatable {
  final String title;
  final String postedAt;
  final String noOfOpenings;

  const OpenPosition({
    required this.title,
    required this.postedAt,
    required this.noOfOpenings,
  });

  @override
  List<Object?> get props => [title, postedAt, noOfOpenings];
}

/// ✅ Updated PermissionData class with all JSON fields
class PermissionData extends Equatable {
  final int id;
  final int webUserId;
  final String empName;
  final String empId;
  final String date;
  final String? department;
  final String type;
  final String from;
  final String to;
  final String days;
  final String reason;
  final String? permissionTiming;
  final String status;
  final String? comment;
  final String? regulationDate;
  final String? regulationReason;
  final String? regulationStatus;
  final String? regulationComment;
  final String? hrStatus;
  final String? managerStatus;
  final String? hrRegulationStatus;
  final String? managerRegulationStatus;
  final String? createdAt;
  final String? updatedAt;

  const PermissionData({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.date,
    required this.department,
    required this.type,
    required this.from,
    required this.to,
    required this.days,
    required this.reason,
    required this.permissionTiming,
    required this.status,
    required this.comment,
    required this.regulationDate,
    required this.regulationReason,
    required this.regulationStatus,
    required this.regulationComment,
    required this.hrStatus,
    required this.managerStatus,
    required this.hrRegulationStatus,
    required this.managerRegulationStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    webUserId,
    empName,
    empId,
    date,
    department,
    type,
    from,
    to,
    days,
    reason,
    permissionTiming,
    status,
    comment,
    regulationDate,
    regulationReason,
    regulationStatus,
    regulationComment,
    hrStatus,
    managerStatus,
    hrRegulationStatus,
    managerRegulationStatus,
    createdAt,
    updatedAt,
  ];
}
