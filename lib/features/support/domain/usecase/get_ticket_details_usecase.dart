
import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';
import 'package:fuoday/features/support/domain/repository/get_ticket_details_repository.dart';

class GetTicketDetailsUseCase {
  final GetTicketDetailsRepository repository;
  GetTicketDetailsUseCase(this.repository);

  Future<Map<String, List<GetTicketDetails>>> call(int webUserId) {
    return repository(webUserId);
  }
}
