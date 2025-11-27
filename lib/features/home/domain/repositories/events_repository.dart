import 'package:fuoday/features/home/domain/entities/event_entity.dart';

abstract class EventsRepository {
  // Get Celebrations
  Future<List<EventEntity>> getCelebrations();

  // Get Announcements
  Future<List<EventEntity>> getAnnouncement();

  // Get Organization Program
  Future<List<EventEntity>> getOrganizationalProgram();
}
