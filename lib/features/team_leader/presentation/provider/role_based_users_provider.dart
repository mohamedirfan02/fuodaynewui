import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/domain/entities/role_based_users_entity.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_role_based_users_usecase.dart';

class RoleBasedUsersProvider extends ChangeNotifier {
  final GetRoleBasedUsersUseCase getRoleBasedUsersUseCase;

  RoleBasedUsersProvider({required this.getRoleBasedUsersUseCase});

  bool isLoading = false;
  RoleBasedUsersEntity? roleBasedUsers;
  String? errorMessage;

  Future<void> fetchRoleBasedUsers(int webUserId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      roleBasedUsers = await getRoleBasedUsersUseCase.cell(webUserId);
      AppLoggerHelper.logInfo('✅ Role Based Users fetched successfully');
    } catch (e) {
      errorMessage = e.toString();
      AppLoggerHelper.logError('❌ Failed to fetch Role Based Users');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
