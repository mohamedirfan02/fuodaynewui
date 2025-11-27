import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/management/presentation/widgets/management_open_positions_card.dart';
import 'package:provider/provider.dart';

class ManagementViewOpenPositions extends StatelessWidget {
  const ManagementViewOpenPositions({
    super.key,
    required HROverviewEntity hrOverview,
  });

  @override
  Widget build(BuildContext context) {
    final positions = context
        .watch<HROverviewProvider>()
        .hrOverview!
        .openPositions;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: positions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final p = positions[index];
        return ManagementOpenPositionsCard(
          openPositonJobDesignation: p.title,
          openPositionJobDescription:
              "Posted at: ${p.postedAt}, Openings: ${p.noOfOpenings}",
        );
      },
    );
  }
}
