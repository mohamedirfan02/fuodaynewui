class HomeFeedsProjectDataModel {
  final List<HomeFeedItem> assigned;
  final List<HomeFeedItem> pending;

  HomeFeedsProjectDataModel({
    required this.assigned,
    required this.pending,
  });

  factory HomeFeedsProjectDataModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedsProjectDataModel(
      assigned: List<HomeFeedItem>.from(
        (json['assigned'] ?? []).map((e) => HomeFeedItem.fromJson(e)),
      ),
      pending: List<HomeFeedItem>.from(
        (json['pending'] ?? []).map((e) => HomeFeedItem.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned': assigned.map((e) => e.toJson()).toList(),
      'pending': pending.map((e) => e.toJson()).toList(),
    };
  }
}

class HomeFeedItem {
  final int id; // ✅ Add this
  final String date;
  final String description;
  final String assignedBy;
  final String assignedTo;
  final String projectName;
  final String progress;
  final String deadline;
  final String comment;        // ✅ new
  final String progressNote;   // ✅ new

  HomeFeedItem({
    required this.id, // ✅ include in constructor
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedTo,
    required this.projectName,
    required this.progress,
    required this.deadline,
    required this.comment,       // ✅
    required this.progressNote,  // ✅
  });

  factory HomeFeedItem.fromJson(Map<String, dynamic> json) {
    return HomeFeedItem(
      id: json['id'] ?? 0, // ✅ parse id from API
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      assignedBy: json['assigned_by'] ?? '',
      assignedTo: json['assigned_to'] ?? '',
      projectName: json['project'] ?? '',
      progress: json['status'] ?? '',
      deadline: json['deadline'] ?? '',
      comment: json['comment'] ?? '',               // ✅
      progressNote: json['progress_note'] ?? '',    // ✅
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // ✅ include when serializing
      'date': date,
      'description': description,
      'assigned_by': assignedBy,
      'assigned_to': assignedTo,
      'project_name': projectName,
      'status': progress,
      'deadline': deadline,
      'comment': comment,            // ✅
      'progress_note': progressNote, // ✅
    };
  }
}

