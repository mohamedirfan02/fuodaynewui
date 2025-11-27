
import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';

abstract class GetTicketDetailsRepository {
  Future<Map<String, List<GetTicketDetails>>> call(int webUserId);
}
