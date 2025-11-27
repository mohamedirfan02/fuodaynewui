class LeaveSummaryModel {
  final String type;
  final int allowed;
  final int taken;
  final int pending;
  final int remaining;
  final int remainingPercentage;

  LeaveSummaryModel({
    required this.type,
    required this.allowed,
    required this.taken,
    required this.pending,
    required this.remaining,
    required this.remainingPercentage,
  });

  factory LeaveSummaryModel.fromJson(Map<String, dynamic> json) {
    return LeaveSummaryModel(
      type: json['type'],
      allowed: int.parse(json['allowed']),
      taken: json['taken'],
      pending: json['pending'],
      remaining: json['remaining'],
      remainingPercentage: json['remaining_percentage'],
    );
  }
}
