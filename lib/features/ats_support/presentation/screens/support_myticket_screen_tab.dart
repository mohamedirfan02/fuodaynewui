import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/features/ats_support/presentation/widgets/k_my_ticket_card.dart';
import 'package:go_router/go_router.dart';

class SupportMyTicketTab extends StatefulWidget {
  const SupportMyTicketTab({super.key});

  @override
  State<SupportMyTicketTab> createState() => _SupportMyTicketTabState();
}

class _SupportMyTicketTabState extends State<SupportMyTicketTab> {
  // ✅ Dummy Ticket Data
  final List<Map<String, dynamic>> tickets = [
    {
      'title': 'How to uninstall the update in Android Studio?',
      'date': 'Feb 3, 2022 20:00',
      'status': TicketStatus.open,
    },
    {
      'title': 'Flutter build failed after adding new dependency',
      'date': 'Feb 5, 2022 15:22',
      'status': TicketStatus.inProgress,
    },
    {
      'title': 'App crashes on startup for Android 13 devices',
      'date': 'Feb 6, 2022 10:45',
      'status': TicketStatus.completed,
    },
    {
      'title': 'How to connect API in GetX structure?',
      'date': 'Feb 7, 2022 08:10',
      'status': TicketStatus.open,
    },
    {
      'title': 'Error: MissingPluginException while using WebView',
      'date': 'Feb 8, 2022 12:00',
      'status': TicketStatus.inProgress,
    },
    {
      'title': 'Push notification not received on iOS',
      'date': 'Feb 9, 2022 18:33',
      'status': TicketStatus.completed,
    },
    {
      'title': 'How to style dropdown items dynamically?',
      'date': 'Feb 10, 2022 09:50',
      'status': TicketStatus.open,
    },
    {
      'title': 'State not updating after API response in GetX',
      'date': 'Feb 11, 2022 11:12',
      'status': TicketStatus.inProgress,
    },
    {
      'title': 'App freezes after splash screen load',
      'date': 'Feb 12, 2022 17:05',
      'status': TicketStatus.completed,
    },
    {
      'title': 'How to show snackbar after form validation?',
      'date': 'Feb 13, 2022 13:25',
      'status': TicketStatus.open,
    },
    {
      'title': 'GetX controller not disposing properly',
      'date': 'Feb 14, 2022 19:45',
      'status': TicketStatus.inProgress,
    },
    {
      'title': 'Layout breaks on web responsive view',
      'date': 'Feb 15, 2022 22:30',
      'status': TicketStatus.completed,
    },
    {
      'title': 'Text overflow issue in ListView item',
      'date': 'Feb 16, 2022 07:45',
      'status': TicketStatus.open,
    },
    {
      'title': 'Dropdown closes automatically when scrolling',
      'date': 'Feb 17, 2022 14:50',
      'status': TicketStatus.inProgress,
    },
    {
      'title': 'How to set up dark mode toggle in Flutter?',
      'date': 'Feb 18, 2022 09:00',
      'status': TicketStatus.completed,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tickets.length, // ✅ 15 dummy items
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: MyTicketCard(
                  title: ticket['title'],
                  date: ticket['date'],
                  status: ticket['status'],
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRouteConstants.atsMyTicketViewScreen);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
