import 'package:fuoday/features/profile/data/datasources/update_profile_remote_datasource.dart';
import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';
import 'package:fuoday/features/profile/domain/repository/update_profile_repository.dart';

class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  final UpdateProfileRemoteDataSource remoteDataSource;

  UpdateProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> updateProfile(UpdateProfileEntity entity) {
    return remoteDataSource.updateProfile(entity);
  }
}
