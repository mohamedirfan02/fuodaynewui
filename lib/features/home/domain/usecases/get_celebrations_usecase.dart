import 'package:fuoday/features/home/domain/entities/event_entity.dart';
import 'package:fuoday/features/home/domain/repositories/events_repository.dart';

class GetCelebrationsUseCase {
  final EventsRepository eventsRepository;

  GetCelebrationsUseCase({required this.eventsRepository});

  Future<List<EventEntity>> call() async {
    return await eventsRepository.getCelebrations();
  }
}
