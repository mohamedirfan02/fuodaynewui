import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';

abstract class UpdateProfileRepository {
  Future<void> updateProfile(UpdateProfileEntity entity);
}