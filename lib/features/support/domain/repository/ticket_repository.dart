

import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';

abstract class TicketRepository {
  Future<void> createTicket(Ticket ticket);
}
