import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';
import 'package:fuoday/features/profile/domain/repository/update_profile_repository.dart';

class UpdateProfileUseCase {
  final UpdateProfileRepository repository;
  UpdateProfileUseCase({required this.repository});

  Future<void> call(UpdateProfileEntity entity) {
    return repository.updateProfile(entity);
  }
}