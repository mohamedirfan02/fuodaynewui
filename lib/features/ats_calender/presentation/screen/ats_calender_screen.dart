import 'dart:math' as MainAxisAxisSize;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

late BuildContext globalContext; // 👈 For time formatting

class AtsCalenderScreen extends StatefulWidget {
  const AtsCalenderScreen({super.key});

  @override
  State<AtsCalenderScreen> createState() => _AtsCalenderScreenState();
}

class _AtsCalenderScreenState extends State<AtsCalenderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  final String currentRoute = AppRouteConstants.atsCalendarScreen;

  @override
  Widget build(BuildContext context) {
    globalContext = context; // 👈 Important

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
        body: const CalendarScreen2(),
      ),
    );
  }
}

class CalendarScreen2 extends StatefulWidget {
  const CalendarScreen2({super.key});

  @override
  State<CalendarScreen2> createState() => _CalendarScreen2State();
}

class AppointmentDetails {
  String title;
  DateTime date;
  String note;
  String eventType;
  TimeOfDay time;

  AppointmentDetails({
    required this.title,
    required this.date,
    required this.note,
    required this.eventType,
    required this.time,
  });
}

class _CalendarScreen2State extends State<CalendarScreen2> {
  List<AppointmentDetails> _notes = [];

  @override
  void initState() {
    super.initState();
    _notes = [
      AppointmentDetails(
        title: "Meeting",
        date: DateTime.now(),
        note: "Client Zoom Meeting",
        eventType: "Operation",
        time: TimeOfDay.now(),
      ),
      AppointmentDetails(
        title: "Follow-up",
        date: DateTime.now().add(const Duration(days: 3)),
        note: "Call for status update",
        eventType: "Announcement",
        time: TimeOfDay(hour: 10, minute: 30),
      ),
    ];
  }

  // --------------------- ADD NOTE ---------------------
  void _addNote(DateTime selectedDate) {
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController noteCtrl = TextEditingController();
    String? selectedEvent;
    TimeOfDay selectedTime = TimeOfDay.now();
    TextEditingController timeCtrl = TextEditingController(
      text: selectedTime.format(context),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            final theme = Theme.of(context);
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Container(
                padding: EdgeInsets.all(18.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: 'New Calendar',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    KVerticalSpacer(height: 18.h),

                    // ⭐ TIME FIELD
                    KAuthTextFormField(
                      label: "Time",
                      controller: timeCtrl,
                      isReadOnly: true,
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (t != null) {
                          setStateSB(() {
                            selectedTime = t;
                            timeCtrl.text = t.format(context);
                          });
                        }
                      },
                    ),
                    KVerticalSpacer(height: 12.h),

                    KText(
                      text: 'Priority Level',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    KVerticalSpacer(height: 6.h),

                    KDropdownTextFormField<String>(
                      hintText: "Select Event",
                      value: selectedEvent,
                      items: const ['Celebration', 'Operation', 'Announcement'],
                      onChanged: (value) =>
                          setStateSB(() => selectedEvent = value),
                    ),
                    KVerticalSpacer(height: 14.h),

                    KAuthTextFormField(
                      label: "Notes",
                      controller: titleCtrl,
                      hintText: "Enter Notes",
                      isRequiredStar: false,
                    ),

                    KVerticalSpacer(height: 18.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KAtsGlowButton(
                          width: 100,
                          text: "Cancel",
                          onPressed: () => Navigator.pop(context),
                          backgroundColor: theme.secondaryHeaderColor,
                          textColor:
                              theme.textTheme.headlineLarge?.color ??
                              AppColors.titleColor, //AppColors.titleColor,,
                        ),
                        KAtsGlowButton(
                          width: 170,
                          text: "New Calendar",
                          gradientColors: AppColors.atsButtonGradientColor,
                          icon: SvgPicture.asset(
                            AppAssetsConstants.addIcon,
                            height: 15,
                            width: 15,
                          ),
                          onPressed: () {
                            if (selectedEvent == null ||
                                titleCtrl.text.trim().isEmpty)
                              return;
                            setState(() {
                              _notes.add(
                                AppointmentDetails(
                                  title: titleCtrl.text,
                                  note: noteCtrl.text,
                                  date: selectedDate,
                                  eventType: selectedEvent!,
                                  time: selectedTime,
                                ),
                              );
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --------------------- EDIT NOTE ---------------------
  void _editNote(AppointmentDetails note) {
    TextEditingController titleCtrl = TextEditingController(text: note.title);
    TextEditingController noteCtrl = TextEditingController(text: note.note);
    String? selectedEvent = note.eventType;
    TimeOfDay selectedTime = note.time;
    TextEditingController timeCtrl = TextEditingController(
      text: selectedTime.format(context),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            // final theme = Theme.of(context);
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Container(
                padding: EdgeInsets.all(18.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ Title + Cancel Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Edit Calendar',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.grey[600],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    KVerticalSpacer(height: 18.h),

                    // ⭐ TIME FIELD
                    KAuthTextFormField(
                      label: "Time",
                      controller: timeCtrl,
                      isReadOnly: true,
                      onTap: () async {
                        final t = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (t != null) {
                          setStateSB(() {
                            selectedTime = t;
                            timeCtrl.text = t.format(context);
                          });
                        }
                      },
                    ),
                    KVerticalSpacer(height: 12.h),

                    KText(
                      text: 'Priority Level',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    KVerticalSpacer(height: 6.h),

                    KDropdownTextFormField<String>(
                      hintText: "Select Event",
                      value: selectedEvent,
                      items: const ['Celebration', 'Operation', 'Announcement'],
                      onChanged: (value) =>
                          setStateSB(() => selectedEvent = value),
                    ),
                    KVerticalSpacer(height: 14.h),

                    KAuthTextFormField(
                      label: "Notes",
                      controller: titleCtrl,
                      hintText: "Enter Notes",
                      isRequiredStar: false,
                    ),
                    KVerticalSpacer(height: 18.h),

                    // ⭐ Bottom Row: Delete + Save
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KAtsGlowButton(
                          //  width: double.infinity,
                          text: "Delete",
                          onPressed: () {
                            setState(() => _notes.remove(note));
                            Navigator.pop(context);
                          },
                          backgroundColor: AppColors.checkOutColor,
                          icon: Icon(Icons.delete_forever, color: Colors.white),
                        ),
                        KAtsGlowButton(
                          // width:100,
                          text: "Save",
                          gradientColors: AppColors.atsButtonGradientColor,
                          onPressed: () {
                            setState(() {
                              note.title = titleCtrl.text;
                              note.note = noteCtrl.text;
                              note.eventType = selectedEvent!;
                              note.time = selectedTime;
                            });
                            KSnackBar.success(
                              context,
                              "Calendar Added Successfully",
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SfCalendar(
      view: CalendarView.month,
      allowDragAndDrop: true,
      showNavigationArrow: true,
      showWeekNumber: true,
      showTodayButton: true,
      showCurrentTimeIndicator: true,
      showDatePickerButton: true,
      todayHighlightColor: theme.primaryColor,
      dataSource: NotesDataSource(_notes, theme.primaryColor),
      onTap: (CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
          final DateTime selectedDate = details.date!;
          final int index = _notes.indexWhere(
            (n) =>
                n.date.year == selectedDate.year &&
                n.date.month == selectedDate.month &&
                n.date.day == selectedDate.day,
          );

          if (index == -1) {
            _addNote(selectedDate);
          } else {
            _editNote(_notes[index]);
          }
        }
      },
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
      ),
    );
  }
}

// 📌 DATA SOURCE — now shows Title + Time
class NotesDataSource extends CalendarDataSource {
  final Color themeColor;
  NotesDataSource(List<AppointmentDetails> source, this.themeColor) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    final n = appointments![index];
    return DateTime(
      n.date.year,
      n.date.month,
      n.date.day,
      n.time.hour,
      n.time.minute,
    );
  }

  @override
  DateTime getEndTime(int index) {
    final start = getStartTime(index);
    return start.add(const Duration(hours: 1));
  }

  @override
  Color getColor(int index) => themeColor;

  @override
  String getSubject(int index) {
    final n = appointments![index];
    final dateTime = DateTime(
      n.date.year,
      n.date.month,
      n.date.day,
      n.time.hour,
      n.time.minute,
    );
    return "${n.title} • ${TimeOfDay.fromDateTime(dateTime).format(globalContext)}";
  }
}
