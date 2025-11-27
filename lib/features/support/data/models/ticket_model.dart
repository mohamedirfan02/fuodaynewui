

import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';

class TicketModel extends Ticket {
  TicketModel({
    required int webUserId,
    required String ticket,
    required String category,
    required int assignedToId,
    required String assignedTo,
    required String priority,
    required String date,
  }) : super(
    webUserId: webUserId,
    ticket: ticket,
    category: category,
    assignedToId: assignedToId,
    assignedTo: assignedTo,
    priority: priority,
    date: date,
  );

  Map<String, dynamic> toJson() {
    return {
      "web_user_id": webUserId,
      "ticket": ticket,
      "category": category,
      "assigned_to_id": assignedToId,
      "assigned_to": assignedTo,
      "priority": priority,
      "date": date,
    };
  }
}
