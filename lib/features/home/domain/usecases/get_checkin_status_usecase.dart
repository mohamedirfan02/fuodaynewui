import 'package:fuoday/features/home/domain/entities/checkin_status_entity.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_status_repository.dart';

class GetCheckinStatusUseCase {
  final CheckinStatusRepository _repository;

  GetCheckinStatusUseCase(this._repository);

  Future<CheckinStatusEntity> call(int webUserId) async {
    return await _repository.getCheckinStatus(webUserId);
  }
}