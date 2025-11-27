import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/teams/domain/entities/team_member_entity.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_member_usecase.dart';

class TeamMembersProvider extends ChangeNotifier {
  final GetTeamMemberUseCase getTeamMemberUseCase;

  TeamMembersProvider({required this.getTeamMemberUseCase});

  List<TeamMemberEntity> _teamMembers = [];
  bool _isLoading = false;
  String? _error;

  List<TeamMemberEntity> get teamMembers => _teamMembers;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchTeamMembers(String webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await getTeamMemberUseCase(webUserId);
      _teamMembers = data;
      AppLoggerHelper.logInfo('✅ Team members fetched: ${_teamMembers.length}');
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError('❌ Failed to fetch team members: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _teamMembers = [];
    _error = null;
    notifyListeners();
  }
}
