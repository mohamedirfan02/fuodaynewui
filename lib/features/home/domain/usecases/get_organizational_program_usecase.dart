import 'package:fuoday/features/home/domain/entities/event_entity.dart';
import 'package:fuoday/features/home/domain/repositories/events_repository.dart';

class GetOrganizationalProgramUseCase {
  final EventsRepository eventsRepository;

  GetOrganizationalProgramUseCase({required this.eventsRepository});

  Future<List<EventEntity>> call() async {
    return await eventsRepository.getOrganizationalProgram();
  }
}
