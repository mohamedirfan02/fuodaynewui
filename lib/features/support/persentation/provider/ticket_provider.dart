/*
import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';

class TicketProvider with ChangeNotifier {
  final CreateTicketUseCase useCase;
  TicketProvider(this.useCase);

  Future<void> submitTicket(Ticket ticket, BuildContext context) async {
    try {
      await useCase(ticket);
      KSnackBar.success(context, '✅ Ticket created successfully');

      Navigator.of(context).pop(); // Close bottom sheet
    } catch (e) {
      KSnackBar.failure(context, '❌ Failed to create ticket');
    }
  }
}
*/
import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/features/support/domain/entities/ticket_entity.dart';
import 'package:fuoday/features/support/domain/usecase/create_ticket_usecase.dart';

class TicketProvider with ChangeNotifier {
  final CreateTicketUseCase useCase;
  TicketProvider(this.useCase);

  Future<void> submitTicket(Ticket ticket, BuildContext context) async {
    try {
      await useCase(ticket);

      // ✅ Check context still valid before using it
      if (context.mounted) {
        KSnackBar.success(context, '✅ Ticket created successfully');

        // ✅ Delay closing slightly to allow snackbar to show safely
        Future.delayed(const Duration(milliseconds: 200), () {
          if (context.mounted) Navigator.of(context).pop();
        });
      }
    } catch (e) {
      if (context.mounted) {
        KSnackBar.failure(context, '❌ Failed to create ticket');
      }
    }
  }
}
