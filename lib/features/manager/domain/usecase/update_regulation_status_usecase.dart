import 'package:fuoday/features/manager/domain/entities/update_regulation_status_entity.dart';
import 'package:fuoday/features/manager/domain/repository/update_regulation_status_repository.dart';

class UpdateRegulationStatusUseCase {
  final UpdateRegulationStatusRepository repository;

  UpdateRegulationStatusUseCase({required this.repository});

  Future<UpdateRegulationStatusEntity> call(
    int id,
    String status,
    String access,
    String module,
  ) {
    return repository.updateRegulationStatus(id, status, access, module);
  }
}
