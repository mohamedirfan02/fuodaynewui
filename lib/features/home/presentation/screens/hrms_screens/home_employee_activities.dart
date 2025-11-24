import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/home/data/model/recognition_model.dart';
import 'package:fuoday/features/home/domain/entities/event_entity.dart';
import 'package:fuoday/features/home/presentation/provider/recognition_provider.dart';
import 'package:fuoday/features/home/presentation/widgets/k_checkin_button.dart';
import 'package:fuoday/features/home/presentation/widgets/k_home_activities_card.dart';
import 'package:fuoday/features/home/presentation/widgets/adding_badge.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeEmployeeActivities extends StatefulWidget {
  const HomeEmployeeActivities({super.key});

  @override
  State<HomeEmployeeActivities> createState() => _HomeEmployeeActivitiesState();
}

class _HomeEmployeeActivitiesState extends State<HomeEmployeeActivities> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
      _startTimer();
    });
  }

  void _initializeData() {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final int webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // Fetch events
    context.allEventsProviderRead.fetchAllEvents();

    // Fetch checkin status
    if (webUserId > 0) {
      context.checkinStatusProviderRead.fetchCheckinStatus(webUserId);
    }
  }

  void _startTimer() {
    // Update UI every second to show real-time working duration
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // FIX: Use listen: false to avoid the provider listening error
      if (mounted) {
        // Check if currently checked in using listen: false
        final checkinStatusProvider =
            context.checkinStatusProviderRead; // This uses listen: false
        if (checkinStatusProvider.isCurrentlyCheckedIn) {
          setState(() {});
        }
      }
    });
  }
  // Updated callback for when badges are submitted

  void _handleBadgesSubmitted(List<Map<String, dynamic>> badges) async {
    final provider = getIt<RecognitionProvider>();

    final recognitions = badges.map((b) {
      return RecognitionModel(
        id: b['id'],
        title: b['title'],
        count: int.tryParse(b['description'] ?? "1") ?? 1,
        imagePath: b['imagePath'], // ✅ local path
      );
    }).toList();

    await provider.saveRecognitions(
      webUserId: 0,
      badges: recognitions, // Provider accepts Entity, Model extends Entity
    );

    AppLoggerHelper.logInfo("Badges sent successfully");
  }

  // Callback for when badges are updated
  void _handleBadgesUpdated() {
    AppLoggerHelper.logWarning('Badges were updated');

    // TODO: Any additional logic after badges are updated
    // For example:
    // - Refresh some data
    // - Update UI
    // - Log analytics event
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Time Formatting
  String formatIsoTime(String? isoString) {
    if (isoString == null) return "00:00:00";
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final formatted = DateFormat('h:mm:ss a').format(dateTime);
      AppLoggerHelper.logInfo("Formatted Time for $isoString → $formatted");
      return formatted;
    } catch (e) {
      AppLoggerHelper.logError("Time format error: $e");
      return "00:00:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    //App theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    // Providers
    final checkInProvider = context.checkInProviderWatch;
    final allEventsProvider = context.allEventsProviderWatch;
    final checkinStatusProvider = context.checkinStatusProviderWatch;

    // Service
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final int webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.allEventsProviderRead.fetchAllEvents(forceRefresh: true),
          if (webUserId > 0)
            context.checkinStatusProviderRead.fetchCheckinStatus(webUserId),
        ]);
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Welcome, $name!",
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: theme.textTheme.headlineLarge?.color,
              ),
              KVerticalSpacer(height: 10.h),
              KText(
                text: "Your work is going to fill a large part of your life...",
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: theme.textTheme.headlineLarge?.color,
              ),
              KVerticalSpacer(height: 20.h),

              /// Timer & Actions
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: theme.primaryColor,
                  ),
                  child: Column(
                    children: [
                      /// ⏱ Timer using API data or stopwatch
                      if (checkinStatusProvider.isLoading)
                        const CircularProgressIndicator(color: Colors.white)
                      else if (checkinStatusProvider.isCurrentlyCheckedIn)
                        // Show real-time working duration from API checkin time
                        KText(
                          text: checkinStatusProvider.formattedWorkingDuration,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: theme.secondaryHeaderColor,
                        )
                      else if (checkInProvider.isCheckedIn)
                        // Show local stopwatch when checked in locally but not via API
                        StreamBuilder<int>(
                          stream: checkInProvider.stopWatchTimer.rawTime,
                          initialData: 0,
                          builder: (_, snapshot) {
                            final rawTime = snapshot.data ?? 0;
                            final duration = Duration(milliseconds: rawTime);

                            final hours = duration.inHours;
                            final minutes = duration.inMinutes.remainder(60);
                            final seconds = duration.inSeconds.remainder(60);

                            final formattedTime =
                                '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

                            return KText(
                              text: formattedTime,
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              color: theme
                                  .secondaryHeaderColor, //AppColors.secondaryColor,
                            );
                          },
                        )
                      else
                        // Show 00:00:00 when not checked in
                        KText(
                          text: "00:00:00",
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                          color: theme.secondaryHeaderColor,
                        ),

                      KVerticalSpacer(height: 8.h),

                      /// Check-in/out button
                      KCheckInButton(
                        textColor: theme.secondaryHeaderColor,
                        text: checkInProvider.isLoading
                            ? "Loading..."
                            : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                  checkInProvider.isCheckedIn)
                            ? "Check Out"
                            : "Check In",
                        fontSize: 8.sp,
                        height: 25.h,
                        width: 100.w,
                        backgroundColor: checkInProvider.isLoading
                            ? Colors.grey
                            : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                  checkInProvider.isCheckedIn)
                            ? isDark
                                  ? AppColors.checkOutColorDark
                                  : AppColors.checkOutColor
                            : isDark
                            ? AppColors.checkInColorDark
                            : AppColors.checkInColor,
                        onPressed: checkInProvider.isLoading
                            ? null
                            : () async {
                                final now = DateTime.now().toIso8601String();

                                if (checkinStatusProvider
                                        .isCurrentlyCheckedIn ||
                                    checkInProvider.isCheckedIn) {
                                  await context.checkInProviderRead
                                      .handleCheckOut(
                                        userId: webUserId,
                                        time: now,
                                      );
                                  // Stop the local stopwatch timer when checking out
                                  checkInProvider.stopWatchTimer.onStopTimer();
                                  AppLoggerHelper.logInfo(
                                    "Check Out Web User Id: $webUserId",
                                  );
                                } else {
                                  await context.checkInProviderRead
                                      .handleCheckIn(
                                        userId: webUserId,
                                        time: now,
                                      );
                                  AppLoggerHelper.logInfo(
                                    "Check In Web User Id: $webUserId",
                                  );

                                  // Start the local stopwatch timer for immediate feedback
                                  checkInProvider.stopWatchTimer.onResetTimer();
                                  checkInProvider.stopWatchTimer.onStartTimer();
                                }

                                // Refresh checkin status after check-in/out
                                if (webUserId > 0) {
                                  await context.checkinStatusProviderRead
                                      .fetchCheckinStatus(webUserId);
                                }
                              },
                      ),

                      KVerticalSpacer(height: 8.h),

                      /// Status & Location
                      if (checkInProvider.isLoading ||
                          checkinStatusProvider.isLoading)
                        const CircularProgressIndicator(color: Colors.white)
                      else
                        Column(
                          children: [
                            KText(
                              text: checkinStatusProvider.isCurrentlyCheckedIn
                                  ? "Status : Checked In"
                                  : checkInProvider.status.isNotEmpty
                                  ? "Status : ${checkInProvider.status}"
                                  : "Status : Not Checked In",
                              fontWeight: FontWeight.w500,
                              fontSize: 10.sp,
                              color: theme.secondaryHeaderColor,
                            ),
                            KVerticalSpacer(height: 8.h),

                            // ///Break In % Break Out
                            // KCheckInButton(
                            //   text: "Break In",
                            //   fontSize: 8.sp,
                            //   height: 25.h,
                            //   width: 100.w,
                            //   backgroundColor: checkInProvider.isLoading
                            //       ? Colors.grey
                            //       : (checkinStatusProvider
                            //                 .isCurrentlyCheckedIn ||
                            //             checkInProvider.isCheckedIn)
                            //       ? AppColors.checkInColor
                            //       : AppColors.checkInColor,
                            //   onPressed: checkInProvider.isLoading
                            //       ? null
                            //       : () async {
                            //           ScaffoldMessenger.of(
                            //             context,
                            //           ).showSnackBar(
                            //             const SnackBar(
                            //               content: Text(
                            //                 "It will be added in a future update",
                            //               ),
                            //               duration: Duration(seconds: 2),
                            //             ),
                            //           );
                            //           // Navigator.of(context).push(
                            //           //   MaterialPageRoute(
                            //           //     builder: (context) =>
                            //           //         DropDownExample(),
                            //           //   ),
                            //           // );
                            //           // final now = DateTime.now()
                            //           //     .toIso8601String();
                            //           //
                            //           // if (checkinStatusProvider
                            //           //         .isCurrentlyCheckedIn ||
                            //           //     checkInProvider.isCheckedIn) {
                            //           //   await context.checkInProviderRead
                            //           //       .handleCheckOut(
                            //           //         userId: webUserId,
                            //           //         time: now,
                            //           //       );
                            //           //   // Stop the local stopwatch timer when checking out
                            //           //   checkInProvider.stopWatchTimer
                            //           //       .onStopTimer();
                            //           //   AppLoggerHelper.logInfo(
                            //           //     "Check Out Web User Id: $webUserId",
                            //           //   );
                            //           // } else {
                            //           //   await context.checkInProviderRead
                            //           //       .handleCheckIn(
                            //           //         userId: webUserId,
                            //           //         time: now,
                            //           //       );
                            //           //   AppLoggerHelper.logInfo(
                            //           //     "Check In Web User Id: $webUserId",
                            //           //   );
                            //           //
                            //           //   // Start the local stopwatch timer for immediate feedback
                            //           //   checkInProvider.stopWatchTimer
                            //           //       .onResetTimer();
                            //           //   checkInProvider.stopWatchTimer
                            //           //       .onStartTimer();
                            //           // }
                            //           //
                            //           // // Refresh checkin status after check-in/out
                            //           // if (webUserId > 0) {
                            //           //   await context.checkinStatusProviderRead
                            //           //       .fetchCheckinStatus(webUserId);
                            //           // }
                            //         },
                            // ),
                            //  KVerticalSpacer(height: 10.h),
                            KAuthFilledBtn(
                              text:
                                  "Location ${checkinStatusProvider.checkinStatus?.location ?? 'onSite'}",
                              fontSize: 8.sp,
                              onPressed: () {},
                              backgroundColor: isDark
                                  ? AppColors.locationOnSiteColorDark
                                  : AppColors.locationOnSiteColor,
                              height: 25.h,
                              width: 125.w,
                              textColor: theme.secondaryHeaderColor,
                            ),
                          ],
                        ),

                      KVerticalSpacer(height: 10.h),

                      /// Check In/Out Times from API
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.login,
                                color: theme.secondaryHeaderColor,
                              ),
                              KText(
                                text:
                                    checkinStatusProvider.formattedCheckinTime,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: theme.secondaryHeaderColor,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: theme.secondaryHeaderColor,
                              ),
                              KText(
                                text:
                                    checkinStatusProvider.formattedCheckoutTime,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: theme.secondaryHeaderColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              KVerticalSpacer(height: 20.h),

              /// Events Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KText(
                    text: "Events All",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: theme.textTheme.headlineLarge?.color,
                  ),
                  Icon(
                    Icons.event,
                    color: theme.textTheme.headlineLarge?.color,
                  ),
                ],
              ),
              KVerticalSpacer(height: 10.h),

              if (allEventsProvider.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (allEventsProvider.error != null)
                KText(
                  text: 'Error: ${allEventsProvider.error}',
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 12.sp,
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildEventCard(
                        context,
                        title: "Celebrations",
                        events: allEventsProvider.celebrations,
                        img: AppAssetsConstants.birthdayImg,
                        bg: theme.primaryColor,
                      ),

                      _buildEventCard(
                        context,
                        title: "Organizational Program",
                        events: allEventsProvider.organizationalPrograms,
                        img: AppAssetsConstants.organizationalProgramImg,
                        bg: isDark
                            ? AppColors.organizationalColorDark
                            : AppColors.organizationalColor,
                      ),
                      _buildEventCard(
                        context,
                        title: "Announcements",
                        events: allEventsProvider.announcements,
                        img: AppAssetsConstants.announcementsImg,
                        bg: isDark
                            ? AppColors.announcementColorDark
                            : AppColors.announcementColor,
                      ),
                    ],
                  ),
                ),
              KVerticalSpacer(height: 10.h),

              // Recognition Wall section header
              KText(
                text: "Recognition Wall :",
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: theme.textTheme.headlineLarge?.color,
              ),

              KVerticalSpacer(height: 10.h),

              // Use the reusable Recognition Wall Widget
              RecognitionWallWidget(
                // title:
                //     "Click the edit icon ✎ to add and manage your achievements !",
                description:
                    'Recognizing our team\'s extraordinary efforts, we express heartfelt gratitude for your dedication, hard work, and the positive impact you bring daily',
                onBadgesSubmitted: _handleBadgesSubmitted,
                onBadgesUpdated: _handleBadgesUpdated,
              ),

              // Show error if checkin status fetch failed
              if (checkinStatusProvider.error != null)
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: KText(
                      text:
                          'Checkin Status Error: ${checkinStatusProvider.error}',
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required List<EventEntity> events,
    required String img,
    required Color bg,
  }) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: KHomeActivitiesCard(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              title: KText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: events.isEmpty
                    ? Center(
                        child: KText(
                          text: "No $title available",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: AppColors.greyColor,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: events.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, index) {
                          final event = events[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: event.title,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: AppColors.titleColor,
                              ),
                              KVerticalSpacer(height: 5.h),
                              KText(
                                text: event.description,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.greyColor,
                              ),
                              KVerticalSpacer(height: 5.h),
                              KText(
                                text: DateFormat(
                                  'dd MMM yyyy',
                                ).format(event.date),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.greyColor,
                              ),
                              KVerticalSpacer(height: 5.h),
                            ],
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  child: Text(
                    "Close",
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        svgImage: img,
        cardImgBgColor: bg,
        cardTitle: title,
        members: "${events.length} members",
        count: "${events.length}",
        bgChipColor: bg,
      ),
    );
  }*/
  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required List<EventEntity> events,
    required String img,
    required Color bg,
  }) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(right: isTablet ? 20.w : 12.w),
      child: KHomeActivitiesCard(
        height: isTablet ? (isLandscape ? 220.h : 270.h) : 180.h,
        width: isTablet ? (isLandscape ? 280.w : 240.w) : 180.w,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              title: KText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 18.sp : 14.sp,
                color: theme.textTheme.headlineLarge?.color,
              ),
              content: SizedBox(
                width: isTablet ? 500.w : double.maxFinite,
                height: isTablet ? 400.h : null,
                child: events.isEmpty
                    ? Center(
                        child: KText(
                          text: "No $title available",
                          fontWeight: FontWeight.w500,
                          fontSize: isTablet ? 14.sp : 12.sp,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: events.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, index) {
                          final theme = Theme.of(context);
                          final event = events[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: event.title,
                                fontWeight: FontWeight.w600,
                                fontSize: isTablet ? 14.sp : 12.sp,
                                color: theme.textTheme.headlineLarge?.color,
                              ),
                              KVerticalSpacer(height: 5.h),
                              KText(
                                text: event.description,
                                fontWeight: FontWeight.w500,
                                fontSize: isTablet ? 13.sp : 11.sp,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              KVerticalSpacer(height: 5.h),
                              KText(
                                text: DateFormat(
                                  'dd MMM yyyy',
                                ).format(event.date),
                                fontWeight: FontWeight.w500,
                                fontSize: isTablet ? 13.sp : 11.sp,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                              KVerticalSpacer(height: 5.h),
                            ],
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  child: Text(
                    "Close",
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet ? 14.sp : 12.sp,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        svgImage: img,
        cardImgBgColor: bg,
        cardTitle: title,
        members: "${events.length} members",
        count: "${events.length}",
        bgChipColor: bg,
      ),
    );
  }
}
