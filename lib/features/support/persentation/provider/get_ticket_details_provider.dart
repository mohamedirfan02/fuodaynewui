import 'package:flutter/material.dart';
import 'package:fuoday/features/support/domain/entities/get_ticket_details_entity.dart';
import 'package:fuoday/features/support/domain/usecase/get_ticket_details_usecase.dart';


class GetTicketDetailsProvider with ChangeNotifier {
  final GetTicketDetailsUseCase useCase;
  GetTicketDetailsProvider(this.useCase);

  Map<String, List<GetTicketDetails>> grouped = {};
  bool loading = false;

  Future<void> fetchTickets(int webUserId, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      grouped = await useCase(webUserId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
