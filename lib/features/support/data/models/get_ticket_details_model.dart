/*

import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';

class GetTicketDetailsModel extends GetTicketDetails {
  GetTicketDetailsModel({
    required int id,
    required int webUserId,
    required String empName,
    required String ticket,
    required String category,
    int? assignedToId,
    String? assignedTo,
    required String assignedBy,
    required String priority,
    required String date,
    required String status,
  }) : super(
    id: id,
    webUserId: webUserId,
    empName: empName,
    ticket: ticket,
    category: category,
    assignedToId: assignedToId,
    assignedTo: assignedTo,
    assignedBy: assignedBy,
    priority: priority,
    date: date,
    status: status,
  );

  factory GetTicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetTicketDetailsModel(
        id: json['id'],
        webUserId: json['web_user_id'],
        empName: json['emp_name'],
        ticket: json['ticket'],
        category: json['category'],
        assignedToId: json['assigned_to_id'],
        assignedTo: json['assigned_to'],
        assignedBy: json['assigned_by'],
        priority: json['priority'],
        date: json['date'],
        status: json['status'],
      );
}
*/

import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';

class GetTicketDetailsModel extends GetTicketDetails {
  GetTicketDetailsModel({
    required int id,
    required int webUserId,
    required String empName,
    required String ticket,
    required String category,
    int? assignedToId,
    String? assignedTo,
    required String assignedBy,
    required String priority,
    required String date,
    required String status,
  }) : super(
         id: id,
         webUserId: webUserId,
         empName: empName,
         ticket: ticket,
         category: category,
         assignedToId: assignedToId,
         assignedTo: assignedTo,
         assignedBy: assignedBy,
         priority: priority,
         date: date,
         status: status,
       );

  factory GetTicketDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetTicketDetailsModel(
      id: json['id'] ?? 0,
      webUserId: json['web_user_id'] ?? 0,
      empName: json['emp_name'] ?? 'Unknown',
      ticket: json['ticket'] ?? '',
      category: json['category'] ?? '',
      assignedToId: json['assigned_to_id'],
      assignedTo: json['assigned_to'] ?? '',
      assignedBy: json['assigned_by'] ?? 'N/A',
      priority: json['priority'] ?? 'Low',
      date: json['date'] ?? '',
      status: json['status'] ?? 'Unknown',
    );
  }
}
