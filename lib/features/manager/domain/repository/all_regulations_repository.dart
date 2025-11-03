import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';

abstract class AllRegulationsRepository {
  Future<AllRegulationsEntity> getAllRegulations(int webUserId);
}
