import 'package:fuoday/features/home/domain/entities/event_entity.dart';

class EventModel {
  final String title;
  final String description;
  final String date;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }

  EventEntity toEntity() {
    return EventEntity(
      title: title,
      description: description,
      date: DateTime.parse(date),
    );
  }
}
