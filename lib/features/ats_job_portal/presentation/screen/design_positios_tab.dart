import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/features/ats_job_portal/presentation/widgets/k_container_card.dart';

class JobPortalDesignPositionsTab extends StatefulWidget {
  const JobPortalDesignPositionsTab({super.key});

  @override
  State<JobPortalDesignPositionsTab> createState() =>
      _JobPortalDesignPositionsTabState();
}

class _JobPortalDesignPositionsTabState
    extends State<JobPortalDesignPositionsTab> {
  final List<Map<String, dynamic>> jobs = [
    {
      "title": "3D Designer",
      "status": "ACTIVE",
      "subtitle": "Designer . Unpixel HQ",
      "candidatesInfo": "5 Candidates Applied",
      "timeInfo": "Created 3m ago",
      "candidateslist": ["M", "A", "LM", 'ss'],
    },
    {
      "title": "UI/UX Designer",
      "status": "ACTIVE",
      "subtitle": "Designer . Tech Corp",
      "candidatesInfo": "1 Candidates Applied",
      "timeInfo": "Created 1h ago",
      "candidateslist": ['s'],
    },
    {
      "title": "3D Designer",
      "status": "ACTIVE",
      "subtitle": "DIT . Unpixel Indonesia",
      "candidatesInfo": "0 Candidates Applied",
      "timeInfo": "Created 3m ago",
      "candidateslist": null,
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
                (item["candidateslist"] as List?)
                    ?.map((e) => e.toString())
                    .toList() ??
                [],
          ),
        );
      },
    );
  }
}
