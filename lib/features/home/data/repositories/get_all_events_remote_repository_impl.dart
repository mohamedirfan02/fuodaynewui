import 'package:fuoday/features/home/data/datasources/remote/event_remote_data_source.dart';
import 'package:fuoday/features/home/domain/entities/event_entity.dart';
import 'package:fuoday/features/home/domain/repositories/events_repository.dart';

class GetAllEventsRemoteRepositoryImpl implements EventsRepository {
  final EventsRemoteDataSource eventsRemoteDataSource;

  GetAllEventsRemoteRepositoryImpl({required this.eventsRemoteDataSource});

  @override
  Future<List<EventEntity>> getAnnouncement() async {
    final models = await eventsRemoteDataSource.fetchAnnouncement();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<EventEntity>> getCelebrations() async {
    final models = await eventsRemoteDataSource.fetchCelebrations();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<EventEntity>> getOrganizationalProgram() async {
    final models = await eventsRemoteDataSource.fetchOrganizationalPrograms();
    return models.map((model) => model.toEntity()).toList();
  }
}
