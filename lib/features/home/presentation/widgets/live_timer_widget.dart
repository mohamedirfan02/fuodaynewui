/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';

// ✅ Optimized LiveTimerDisplay Widget - Handles loading and updates independently
class LiveTimerDisplay extends StatefulWidget {
  final dynamic checkinStatusProvider;
  final dynamic checkInProvider;
  final ThemeData theme;

  const LiveTimerDisplay({
    Key? key,
    required this.checkinStatusProvider,
    required this.checkInProvider,
    required this.theme,
  }) : super(key: key);

  @override
  State<LiveTimerDisplay> createState() => _LiveTimerDisplayState();
}

class _LiveTimerDisplayState extends State<LiveTimerDisplay> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Only start timer if checked in via API
    if (widget.checkinStatusProvider.isCurrentlyCheckedIn) {
      _startTimer();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (widget.checkinStatusProvider.isCurrentlyCheckedIn) {
  //     _startTimer(); // 🔥 ensures timer starts even after hot restart
  //   }
  // }

  @override
  void didUpdateWidget(LiveTimerDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle check-in state changes
    if (widget.checkinStatusProvider.isCurrentlyCheckedIn &&
        !oldWidget.checkinStatusProvider.isCurrentlyCheckedIn) {
      _startTimer();
    } else if (!widget.checkinStatusProvider.isCurrentlyCheckedIn &&
        oldWidget.checkinStatusProvider.isCurrentlyCheckedIn) {
      _stopTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator
    if (widget.checkinStatusProvider.isLoading) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    // Show real-time working duration from API checkin time
    if (widget.checkinStatusProvider.isCurrentlyCheckedIn) {
      return KText(
        text: widget.checkinStatusProvider.formattedWorkingDuration,
        fontWeight: FontWeight.w500,
        fontSize: 17.sp,
      );
    }

    // Show local stopwatch when checked in locally but not via API
    if (widget.checkInProvider.isCheckedIn) {
      return StreamBuilder<int>(
        stream: widget.checkInProvider.stopWatchTimer.rawTime,
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
          );
        },
      );
    }

    // Show 00:00:00 when not checked in
    return KText(
      text: "00:00:00",
      fontWeight: FontWeight.w500,
      fontSize: 17.sp,
    );
  }
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';

//  LiveTimerDisplay Widget - Properly handles timer lifecycle and hot restart
class LiveTimerDisplay extends StatefulWidget {
  final dynamic checkinStatusProvider;
  final dynamic checkInProvider;
  final ThemeData theme;

  const LiveTimerDisplay({
    Key? key,
    required this.checkinStatusProvider,
    required this.checkInProvider,
    required this.theme,
  }) : super(key: key);

  @override
  State<LiveTimerDisplay> createState() => _LiveTimerDisplayState();
}

class _LiveTimerDisplayState extends State<LiveTimerDisplay> {
  Timer? _timer;
  //   1: Added flag to track timer state
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    //   2: Start timer in initState
    _checkAndStartTimer();
  }

  @override
  void didUpdateWidget(LiveTimerDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);

    //   3: Re-check timer status on widget update
    _checkAndStartTimer();

    // Handle check-out (stop timer when checked out)
    if (!widget.checkinStatusProvider.isCurrentlyCheckedIn &&
        oldWidget.checkinStatusProvider.isCurrentlyCheckedIn) {
      _stopTimer();
    }
  }

  //   4: New method to check and start timer consistently
  void _checkAndStartTimer() {
    final shouldRunTimer = widget.checkinStatusProvider.isCurrentlyCheckedIn;

    if (shouldRunTimer && !_isTimerRunning) {
      _startTimer();
    } else if (!shouldRunTimer && _isTimerRunning) {
      _stopTimer();
    }
  }

  void _startTimer() {
    //   5: Prevent multiple timers
    if (_isTimerRunning) return;

    _timer?.cancel();
    _isTimerRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          // Timer tick - forces rebuild to show updated time
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
  }

  //   6: Added reassemble for hot restart handling
  @override
  void reassemble() {
    super.reassemble();
    // Restart timer after hot restart if should be running
    if (widget.checkinStatusProvider.isCurrentlyCheckedIn) {
      _stopTimer();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    //   7: Enhanced loading indicator with size
    if (widget.checkinStatusProvider.isLoading) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: CircularProgressIndicator(
          color: theme.primaryColor,
          strokeWidth: 2.5,
        ),
      );
    }

    // Show real-time working duration from API checkin time
    if (widget.checkinStatusProvider.isCurrentlyCheckedIn) {
      return KText(
        text: widget.checkinStatusProvider.formattedWorkingDuration,
        fontWeight: FontWeight.w500,
        fontSize: 17.sp,
      );
    }

    // Show local stopwatch when checked in locally but not via API
    if (widget.checkInProvider.isCheckedIn) {
      return StreamBuilder<int>(
        stream: widget.checkInProvider.stopWatchTimer.rawTime,
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
          );
        },
      );
    }

    // Show 00:00:00 when not checked in
    return KText(
      text: "00:00:00",
      fontWeight: FontWeight.w500,
      fontSize: 17.sp,
    );
  }
}
