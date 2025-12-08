import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/ats_index/presentation/widgets/kchat_list.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';
import 'index_mail_screen.dart';

class AtsIndexScreen extends StatefulWidget {
  const AtsIndexScreen({super.key});

  @override
  State<AtsIndexScreen> createState() => _AtsIndexScreenState();
}

class _AtsIndexScreenState extends State<AtsIndexScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

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
      'isforward': 'false',
    },
    {
      'name': 'Nguyen, Mai',
      'email': 'nguyen.mai@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'true',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'true',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'true',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'true',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '1:30PM',
      'avatarUrl': '',
      'isforward': 'false',
    },
    {
      'name': 'Miss, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message': 'Hi Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'false',
    },
    {
      'name': 'Director, Father',
      'email': 'miss.father@gbrashemailcom',
      'subject': 'Thank you for your application at Fiber Office',
      'message':
          'Hello Cecilia, The main duties of a Senior Product Designer...',
      'time': '12:35PM',
      'avatarUrl': '',
      'isforward': 'true',
    },
  ];

  // Filter conversations based on search query
  List<Map<String, dynamic>> get filteredConversations {
    if (_searchQuery.isEmpty) {
      return conversations;
    }

    return conversations.where((chat) {
      final name = chat['name']?.toString().toLowerCase() ?? '';
      final email = chat['email']?.toString().toLowerCase() ?? '';
      final subject = chat['subject']?.toString().toLowerCase() ?? '';
      final message = chat['message']?.toString().toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();

      return name.contains(query) ||
          email.contains(query) ||
          subject.contains(query) ||
          message.contains(query);
    }).toList();
  }

  void _handleChatTap(Map<String, dynamic> chat) {
    print('Tapped: ${chat['name']}');

    // Navigate to AtsIndexMailScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AtsIndexMailScreen()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
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
          color: theme.cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.h),

                KText(
                  text: "Index",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 16.h),

                KAuthTextFormField(
                  controller: _searchController,
                  hintText: 'Search anything…',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),

                /*Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),*/
                SizedBox(height: 16.h),
                Expanded(
                  child: filteredConversations.isEmpty
                      ? Center(
                          child: KText(
                            text: 'No results found',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : KChatList(
                          conversations: filteredConversations,
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
