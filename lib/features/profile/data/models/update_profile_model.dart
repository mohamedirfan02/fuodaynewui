import 'package:dio/dio.dart';
import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';

class UpdateProfileModel {
  static FormData fromEntity(UpdateProfileEntity entity) {
    final Map<String, dynamic> data = {
      'web_user_id': entity.webUserId,
      'first_name': entity.firstName,
      'last_name': entity.lastName,
      'about': entity.about,
      'dob': entity.dob,
      'address': entity.address,
      'phone': entity.phone,

    };

    final formData = FormData.fromMap(data);

    if (entity.profileImageFile != null) {
      formData.files.add(
        MapEntry(
          'profile',
          MultipartFile.fromFileSync(
            entity.profileImageFile!.path,
            filename: 'profile.jpg',
          ),
        ),
      );
    }

    return formData;
  }
}