import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/features/ats_job_portal/presentation/widgets/k_container_card.dart';

class SupportMyTicketTab extends StatefulWidget {
  const SupportMyTicketTab({super.key});

  @override
  State<SupportMyTicketTab> createState() => _SupportMyTicketTabState();
}

class _SupportMyTicketTabState extends State<SupportMyTicketTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Your job cards here
          JobCard(
            title: '3D Designer',
            status: 'ACTIVE',
            subtitle: 'Designer . Unpixel HQ',
            candidatesInfo: '0 Candidates Applied',
            timeInfo: 'Created 3m ago',
          ),
          SizedBox(height: 16.h),
          JobCard(
            title: 'UI/UX Designer',
            status: 'ACTIVE',
            subtitle: 'Designer . Tech Corp',
            candidatesInfo: '5 Candidates Applied',
            timeInfo: 'Created 1h ago',
          ),
          SizedBox(height: 16.h),
          JobCard(
            title: '3D Designer',
            status: 'ACTIVE',
            subtitle: 'DIT . Unpixel Indonesia',
            candidatesInfo: '0 Candidates Applied',
            timeInfo: 'Created 3m ago',
          ),
          // Add more cards as needed
        ],
      ),
    );
  }
}
