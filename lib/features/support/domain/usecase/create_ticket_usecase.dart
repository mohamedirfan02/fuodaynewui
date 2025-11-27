

import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/domain/repository/ticket_repository.dart';

class CreateTicketUseCase {
  final TicketRepository repository;
  CreateTicketUseCase(this.repository);

  Future<void> call(Ticket ticket) async {
    await repository.createTicket(ticket);
  }
}
