

import 'package:fuoday/features/support/data/datasource/get_ticket_details_datasource.dart';
import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';
import 'package:fuoday/features/support/domain/repository/get_ticket_details_repository.dart';

class GetTicketDetailsRepositoryImpl implements GetTicketDetailsRepository {
  final GetTicketDetailsDataSource remote;
  GetTicketDetailsRepositoryImpl(this.remote);

  @override
  Future<Map<String, List<GetTicketDetails>>> call(int webUserId) async {
    final grouped = await remote.fetchTickets(webUserId);
    return grouped.map((k, v) => MapEntry(
      k,
      v.map((e) => e as GetTicketDetails).toList(),
    ));
  }
}
