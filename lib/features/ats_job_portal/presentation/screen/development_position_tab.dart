import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/features/ats_job_portal/presentation/widgets/k_container_card.dart';

class JobPortalDevelopmentPositionTab extends StatefulWidget {
  const JobPortalDevelopmentPositionTab({super.key});

  @override
  State<JobPortalDevelopmentPositionTab> createState() =>
      _JobPortalDevelopmentPositionTabState();
}

class _JobPortalDevelopmentPositionTabState
    extends State<JobPortalDevelopmentPositionTab> {
  final List<Map<String, dynamic>> jobs = [
    {
      "title": "3D Designer",
      "status": "ACTIVE",
      "subtitle": "Designer . Unpixel HQ",
      "candidatesInfo": "5 Candidates Applied",
      "timeInfo": "Created 3m ago",
      "candidatesList": ["M", "A", "LM", 'ss'],
    },
    {
      "title": "UI/UX Designer",
      "status": "ACTIVE",
      "subtitle": "Designer . Tech Corp",
      "candidatesInfo": "1 Candidates Applied",
      "timeInfo": "Created 1h ago",
      "candidatesList": [],
    },
    {
      "title": "3D Designer",
      "status": "ACTIVE",
      "subtitle": "DIT . Unpixel Indonesia",
      "candidatesInfo": "0 Candidates Applied",
      "timeInfo": "Created 3m ago",
      "candidatesList": ['MM', 'sk'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final item = jobs[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: JobCard(
            title: item["title"],
            status: item["status"],
            subtitle: item["subtitle"],
            candidatesInfo: item["candidatesInfo"],
            timeInfo: item["timeInfo"],
            candidateslist:
                (item["candidatesList"] as List?)
                    ?.map((e) => e.toString())
                    .toList() ??
                [],
          ),
        );
      },
    );
  }
}
