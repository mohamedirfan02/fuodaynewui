import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/domain/repository/ticket_repository.dart';
import 'package:fuoday/features/support/data/datasource/ticket_remote_datasource.dart';
import 'package:fuoday/features/support/data/models/ticket_model.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createTicket(Ticket ticket) async {
    final model = ticket is TicketModel
        ? ticket
        : TicketModel(
      webUserId: ticket.webUserId,
      ticket: ticket.ticket,
      category: ticket.category,
      assignedToId: ticket.assignedToId,
      assignedTo: ticket.assignedTo,
      priority: ticket.priority,
      date: ticket.date,
    );

    await remoteDataSource.createTicket(model);
  }
}
