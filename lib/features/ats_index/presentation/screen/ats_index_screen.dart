import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
// import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/kchat_list.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/router/app_route_constants.dart';
import 'index_mail_screen.dart';

class AtsIndexScreen extends StatefulWidget {
  const AtsIndexScreen({super.key});

  @override
  State<AtsIndexScreen> createState() => _AtsIndexScreenState();
}

class _AtsIndexScreenState extends State<AtsIndexScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute = AppRouteConstants.atsIndexScreen;

  // Your chat data - change this list to show different chats
  final List<Map<String, dynamic>> conversations = [
    {
      'name': 'John, Thomas',
      'email': 'john.thomas@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Nguyen, Mai',
      'email': 'nguyen.mai@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
    },
    // Add more conversations here...
  ];

  void _handleChatTap(Map<String, dynamic> chat) {
    print('Tapped: ${chat['name']}');

    // Navigate to AtsIndexMailScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AtsIndexMailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    return PopScope(
      canPop: false, // Prevent default pop
      onPopInvokedWithResult: (didPop, result) async {
        // If not popped automatically
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
            // If already on Home → allow exiting app
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AtsKAppBarWithDrawer(
          userName: "",
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: "",
          showUserInfo: true,
          onDrawerPressed: _openDrawer,
          onNotificationPressed: () {},
        ),
        drawer: KAtsDrawer(
          userEmail: email,
          userName: name,
          profileImageUrl: profilePhoto,
          currentRoute: currentRoute,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.atsHomepageBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.h),
                KText(
                  text: "Index",
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  color: AppColors.titleColor,
                ),
                SizedBox(height: 16.h),
                // Use the reusable widget!
                Expanded(
                  child: KChatList(
                    conversations: conversations,
                    onItemTap: _handleChatTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
