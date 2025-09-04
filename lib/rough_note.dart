// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
// import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
// import 'package:fuoday/commons/widgets/k_drawer.dart';
// import 'package:fuoday/commons/widgets/k_image_picker_options_bottom_sheet.dart';
// import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
// import 'package:fuoday/commons/widgets/k_tab_bar.dart';
// import 'package:fuoday/commons/widgets/k_text.dart';
// import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
// import 'package:fuoday/core/di/injection.dart';
// import 'package:fuoday/core/helper/app_logger_helper.dart';
// import 'package:fuoday/core/service/dio_service.dart';
// import 'package:fuoday/core/service/hive_storage_service.dart';
// import 'package:fuoday/core/service/secure_storage_service.dart';
// import 'package:fuoday/core/themes/app_colors.dart';
// import 'package:fuoday/core/utils/image_picker.dart';
// import 'package:fuoday/features/home/presentation/screens/add_task.dart';
// import 'package:fuoday/features/home/presentation/screens/home_employee_activities.dart';
// import 'package:fuoday/features/home/presentation/screens/home_employee_feeds.dart';
//
// class HomeEmployeeScreen extends StatefulWidget {
//   const HomeEmployeeScreen({super.key});
//
//   @override
//   State<HomeEmployeeScreen> createState() => _HomeEmployeeScreenState();
// }
//
// class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
//   File? _pickedCoverFile; // for local picked image
//
//   // Scaffold Key
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Auth Token
//   String? authToken;
//
//   @override
//   void initState() {
//     loadAuthToken();
//     super.initState();
//   }
//
//   Future<void> loadAuthToken() async {
//     try {
//       final secureStorageService = getIt<SecureStorageService>();
//       authToken = await secureStorageService.getToken();
//
//       AppLoggerHelper.logInfo("Auth Token: $authToken");
//
//       if (authToken != null) {
//         DioService().updateAuthToken(authToken!);
//       }
//     } catch (e) {
//       AppLoggerHelper.logInfo("Auth Token error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Get employee details from Hive with error handling
//     final hiveService = getIt<HiveStorageService>();
//     final employeeDetails = hiveService.employeeDetails;
//
//     // Safe extraction of employee details
//     final name = employeeDetails?['name'] ?? "No Name";
//     final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
//     final empId = employeeDetails?['empId'] ?? "No Employee ID";
//     final designation = employeeDetails?['designation'] ?? "No Designation";
//     final email = employeeDetails?['email'] ?? "No Email";
//
//     // Debugging Logger
//     AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
//     AppLoggerHelper.logInfo(
//       "Has Employee Details: ${hiveService.hasEmployeeDetails}",
//     );
//
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: KAppBarWithDrawer(
//           userName: name,
//           cachedNetworkImageUrl: profilePhoto,
//           userDesignation: designation,
//           showUserInfo: false,
//           onDrawerPressed: () => _scaffoldKey.currentState?.openDrawer(),
//           onNotificationPressed: () {},
//         ),
//         drawer: KDrawer(
//           userEmail: email,
//           userName: name,
//           profileImageUrl: profilePhoto,
//         ),
//         body: KLinearGradientBg(
//           gradientColor: AppColors.employeeGradientColor,
//           child: Padding(
//             padding: EdgeInsets.only(top: 10.h),
//             child: Column(
//               children: [
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     // 🔹 Background Cover Image
//                     Container(
//                       height: 130.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: AppColors.employeeGradientColor, // keep your purple gradient
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         image: _pickedCoverFile != null
//                             ? DecorationImage(
//                           image: FileImage(_pickedCoverFile!),
//                           fit: BoxFit.cover,
//                         )
//                             : null,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20.r),
//                           topRight: Radius.circular(20.r),
//                           bottomLeft: Radius.circular(10.r),
//                           bottomRight: Radius.circular(10.r),
//                         ),
//                       ),
//                     ),
//
//                     // 🔹 Cover Edit Button (top-right)
//                     Positioned(
//                       top: 10.h,
//                       right: 10.w,
//                       child: GestureDetector(
//                         onTap: () async {
//                           final appImagePicker = AppImagePicker();
//
//                           showModalBottomSheet(
//                             context: context,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(16.r),
//                               ),
//                             ),
//                             builder: (context) {
//                               return KImagePickerOptionsBottomSheet(
//                                 onCameraTap: () async {
//                                   final image = await appImagePicker.pickImageFromCamera();
//                                   if (image != null) {
//                                     setState(() => _pickedCoverFile = image);
//                                     Navigator.of(context).pop();
//                                   }
//                                 },
//                                 onGalleryTap: () async {
//                                   final image = await appImagePicker.pickImageFromGallery();
//                                   if (image != null) {
//                                     setState(() => _pickedCoverFile = image);
//                                     Navigator.of(context).pop();
//                                   }
//                                 },
//                               );
//                             },
//                           );
//                         },
//                         child: Container(
//                           height: 36.h,
//                           width: 36.w,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.secondaryColor,
//                             border: Border.all(
//                               color: AppColors.greyColor,
//                               width: 1,
//                             ),
//                           ),
//                           child: Icon(
//                             Icons.camera_alt,
//                             size: 18.sp,
//                             color: AppColors.primaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // 🔹 Profile + Details
//                     Positioned(
//                       bottom: -20.h,
//                       left: 20.w,
//                       child: Row(
//                         children: [
//                           KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),
//                           SizedBox(width: 16.w),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               KText(
//                                 text: name,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 14.sp,
//                                 color: AppColors.titleColor,
//                               ),
//                               KText(
//                                 text: "Employee Id: $empId",
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 10.sp,
//                                 color: AppColors.titleColor,
//                               ),
//                               KText(
//                                 text: email,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 10.sp,
//                                 color: AppColors.titleColor,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30.h), // space to fix profile overlap
//
//
//                 // KVerticalSpacer(height: 20.h),
//
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r),
//                       ),
//                       color: AppColors.secondaryColor,
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 20.w,
//                             vertical: 20.h,
//                           ),
//                           child: KTabBar(
//                             tabs: [
//                               Tab(text: "Activity"),
//                               Tab(text: "Feeds"),
//                               Tab(text: "Add Task"),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             children: [
//                               HomeEmployeeActivities(),
//                               HomeEmployeeFeeds(),
//                               AddTask(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
