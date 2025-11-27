import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/support/persentation/provider/get_ticket_details_provider.dart';
import 'package:fuoday/features/support/persentation/widgets/support_info_card.dart';
import 'package:provider/provider.dart';

class SupportCompleted extends StatelessWidget {
  const SupportCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetTicketDetailsProvider>(
      builder: (_, prov, __) {
        final list = prov.grouped['completed'] ?? [];

        if (prov.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (list.isEmpty) {
          return const Center(child: Text("No completed tickets."));
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (_, __) => KVerticalSpacer(height: 10.h),
          itemBuilder: (_, i) {
            final t = list[i];
            return SupportInfoCard(
              priority: '${t.priority} Priority',
              issue: t.category,
              userName: t.empName,
              ticketIssue: t.ticket,
              ticketIssuedDate: t.date,
              avatarText: t.empName.isNotEmpty ? t.empName[0] : '?',
              domain: t.assignedBy,
            );
          },
        );
      },
    );
  }
}
