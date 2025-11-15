import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_ bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String selectedMonth;
  DateTime? _currentViewDate;

  // default holiday for sunday
  List<Appointment> _getSundayHolidays(DateTime monthDate) {
    final List<Appointment> sundays = [];
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Start from the first day of the month
    DateTime firstDay = DateTime(monthDate.year, monthDate.month, 1);

    // Find the first Sunday in the month
    DateTime firstSunday = firstDay.add(
      Duration(days: (DateTime.sunday - firstDay.weekday) % 7),
    );

    // Loop through all Sundays in the month
    for (
      DateTime d = firstSunday;
      d.month == monthDate.month;
      d = d.add(const Duration(days: 7))
    ) {
      sundays.add(
        Appointment(
          startTime: DateTime(d.year, d.month, d.day, 0, 0),
          endTime: DateTime(d.year, d.month, d.day, 23, 59),
          subject: "Holiday (Sunday)",
          color: isDark
              ? AppColors.checkOutColorDark
              : AppColors.checkOutColor, // 🔴 Highlighted holiday color
        ),
      );
    }

    return sundays;
  }

  List<Appointment> _buildAppointments(List shifts, DateTime monthDate) {
    final List<Appointment> appointments = [];
    final theme = Theme.of(context);

    for (var shift in shifts) {
      final startDate = DateTime.tryParse(shift.startDate ?? shift.date ?? '');
      final endDate = DateTime.tryParse(shift.endDate ?? shift.date ?? '');
      final shiftStart = shift.shiftStart ?? '09:00';
      final shiftEnd = shift.shiftEnd ?? '18:00';

      if (startDate != null && endDate != null) {
        for (
          DateTime d = startDate;
          !d.isAfter(endDate);
          d = d.add(const Duration(days: 1))
        ) {
          appointments.add(
            Appointment(
              startTime: parseShiftDate(
                DateFormat('yyyy-MM-dd').format(d),
                shiftStart,
              ),
              endTime: parseShiftDate(
                DateFormat('yyyy-MM-dd').format(d),
                shiftEnd,
              ),
              subject: '${shift.empName} ($shiftStart - $shiftEnd)',
              color: theme.primaryColor,
              isAllDay: false,
            ),
          );
        }
      }
    }

    // Add default Sunday holidays
    appointments.addAll(_getSundayHolidays(monthDate));

    return appointments;
  }

  DateTime parseShiftDate(String date, String time) {
    // Ensure time has seconds
    final normalizedTime = time.length == 5 ? '$time:00' : time;
    try {
      return DateTime.parse('$date $normalizedTime');
    } catch (_) {
      // fallback if parsing fails
      return DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = DateFormat('yyyy-MM').format(now);
    _currentViewDate = now;

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadShifts());
  }

  void _loadShifts({bool forceRefresh = false}) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserId = employeeDetails?['web_user_id']?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        context.shiftScheduleProviderRead.fetchMonthlyShifts(
          webUserId: webUserId,
          month: selectedMonth,
          forceRefresh: forceRefresh,
        );
      });
    }
  }

  void _onViewChanged(ViewChangedDetails details) {
    if (details.visibleDates.isEmpty) return;

    // Use the middle visible date as current view reference
    _currentViewDate = details.visibleDates[details.visibleDates.length ~/ 2];
    final newMonth = DateFormat('yyyy-MM').format(_currentViewDate!);

    if (newMonth != selectedMonth) {
      selectedMonth = newMonth;
      Future.microtask(() => _loadShifts(forceRefresh: true));
    }
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    final provider = context.shiftScheduleProviderWatch;

    return Scaffold(
      key: _scaffoldKey,
      appBar: KAppBarWithDrawer(
        userName: name,
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: designation,
        showUserInfo: true,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userName: name,
        userEmail: email,
        profileImageUrl: profilePhoto,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SfCalendar(
                view: CalendarView.month,
                dataSource: ShiftAppointmentDataSource(
                  _buildAppointments(
                    provider.shifts,
                    _currentViewDate ?? DateTime.now(),
                  ),
                ),
                initialDisplayDate: _currentViewDate,
                onViewChanged: _onViewChanged,
                showNavigationArrow: true,
                showWeekNumber: true,
                showTodayButton: true,
                showCurrentTimeIndicator: true,
                showDatePickerButton: true,
                todayHighlightColor: theme.primaryColor,
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              ),
      ),
    );
  }
}

class ShiftAppointmentDataSource extends CalendarDataSource {
  ShiftAppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
