import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';
import 'package:fuoday/features/manager/domain/repository/all_regulations_repository.dart';

class GetAllRegulationsUseCase {
  final AllRegulationsRepository repository;

  GetAllRegulationsUseCase({required this.repository});

  Future<AllRegulationsEntity> call(int webUserId) {
    return repository.getAllRegulations(webUserId);
  }
}
