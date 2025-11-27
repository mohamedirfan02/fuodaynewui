import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/features/ats_support/presentation/screens/ticket_view_screen.dart';
import 'package:fuoday/features/ats_support/presentation/widgets/k_ticket_card.dart';

class SupportAllTicketTab extends StatefulWidget {
  const SupportAllTicketTab({super.key});

  @override
  State<SupportAllTicketTab> createState() => _SupportAllTicketTabState();
}

class _SupportAllTicketTabState extends State<SupportAllTicketTab> {
  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w), //
      child: Column(
        children: [
          // Home Page Title
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KText(
                  text: "Total: 1234 Tickets",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  // color: AppColors.titleColor,
                ),
                //const SizedBox(width: 60), // spacing between text and emoji
                SvgPicture.asset(
                  AppAssetsConstants.filterIcon,
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  //SVG IMAGE COLOR
                  colorFilter: ColorFilter.mode(
                    theme.textTheme.headlineLarge?.color ?? Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          KVerticalSpacer(height: 16.h),
          TicketCard(
            title: 'My app is very buggy',
            userName: 'brentrodriguez',
            submittedDate: 'Nov 22, 2022',
            priority: 'Highest',
            ticketId: '1234',
            status: TicketStatus.open,
            icon: SvgPicture.asset(
              AppAssetsConstants.ticketIcon,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketViewScreen()),
              );
            },
          ),

          SizedBox(height: 16.h),

          // In Progress Ticket
          TicketCard(
            title: 'Login page not working',
            userName: 'johndoe',
            submittedDate: 'Nov 23, 2022',
            priority: 'High',
            ticketId: '1235',
            status: TicketStatus.inProgress,
            icon: SvgPicture.asset(
              AppAssetsConstants.ticketIcon,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketViewScreen()),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Completed Ticket
          TicketCard(
            title: 'Add dark mode feature',
            userName: 'janedoe',
            submittedDate: 'Nov 20, 2022',
            priority: 'Medium',
            ticketId: '1233',
            status: TicketStatus.completed,
            icon: SvgPicture.asset(
              AppAssetsConstants.ticketIcon,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketViewScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
