import 'package:fuoday/features/manager/domain/entities/update_regulation_status_entity.dart';

abstract class UpdateRegulationStatusRepository {
  Future<UpdateRegulationStatusEntity> updateRegulationStatus(
    int id,
    String status,
    String access,
    String module,
  );
}
