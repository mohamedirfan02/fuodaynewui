import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/leave_tracker/domain/usecase/get_leave_summary_usecase.dart';
import 'package:fuoday/features/leave_tracker/presentation/widgets/leave_balance_card.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import '../../domain/entities/leave_summary_entity.dart';

class LeaveBalance extends StatefulWidget {
  const LeaveBalance({super.key});

  @override
  State<LeaveBalance> createState() => _LeaveBalanceState();
}

class _LeaveBalanceState extends State<LeaveBalance> {
  late GetLeaveSummaryUseCase getLeaveSummaryUseCase;
  List<LeaveSummaryEntity> leaveSummary = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getLeaveSummaryUseCase = getIt<GetLeaveSummaryUseCase>();
    _loadLeaveData();
  }

  Future<void> _loadLeaveData() async {
    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();
    if (webUserId == null) return;

    final data = await getLeaveSummaryUseCase(webUserId);
    setState(() {
      leaveSummary = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemBuilder: (context, index) {
              final item = leaveSummary[index];
              return LeaveBalanceCard(
                usedAmount: item.taken.toDouble(),
                totalAmount: item.allowed.toDouble(),
                title: item.type,
                usedLabel: "Taken",
                unusedLabel: "Remaining",
                chartSize: 140.w,
              );
            },
            separatorBuilder: (context, index) => KVerticalSpacer(height: 10.h),
            itemCount: leaveSummary.length,
          );
  }
}
