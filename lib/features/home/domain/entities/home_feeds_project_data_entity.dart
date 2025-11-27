class HomeFeedsProjectDataEntity {
  final List<HomeFeedEntity> assigned;
  final List<HomeFeedEntity> pending;

  HomeFeedsProjectDataEntity({
    required this.assigned,
    required this.pending,
  });
}

class HomeFeedEntity {
  final int id; // ✅ Add this
  final String date;
  final String description;
  final String assignedBy;
  final String assignedTo;
  final String projectName;
  final String progress;
  final String deadline;
  final String? comment;        // ✅ new
  final String? progressNote;   // ✅ new

  HomeFeedEntity({
    required this.id, // ✅ include in constructor
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedTo,
    required this.projectName,
    required this.progress,
    required this.deadline,
     this.comment,        // ✅
     this.progressNote,   // ✅
  });
}
