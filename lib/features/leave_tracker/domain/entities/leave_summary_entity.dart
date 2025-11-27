class LeaveSummaryEntity {
  final String type;
  final int allowed;
  final int taken;
  final int pending;
  final int remaining;
  final int remainingPercentage;

  LeaveSummaryEntity({
    required this.type,
    required this.allowed,
    required this.taken,
    required this.pending,
    required this.remaining,
    required this.remainingPercentage,
  });
}
