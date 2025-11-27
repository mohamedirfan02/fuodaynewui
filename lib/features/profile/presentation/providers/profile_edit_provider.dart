import 'package:flutter/cupertino.dart';
import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';
import 'package:fuoday/features/profile/domain/usecases/update_profile_usecase.dart';

class ProfileEditProvider extends ChangeNotifier {
  bool _isEditMode = false;
  final UpdateProfileUseCase updateProfileData;

  ProfileEditProvider({required this.updateProfileData});

  bool get isEditMode => _isEditMode;

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  void cancelEdit() {
    _isEditMode = false;
    notifyListeners();
  }

  Future<void> submitUpdate(UpdateProfileEntity entity) async {
    await updateProfileData.call(entity);
    toggleEditMode(); // Exit edit mode after updating
  }
}