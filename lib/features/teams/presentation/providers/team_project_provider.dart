import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/teams/domain/entities/team_project_entity.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_project_usecase.dart';

class TeamProjectProvider extends ChangeNotifier {
  final GetTeamProjectsUseCase getTeamProjectsUseCase;

  TeamProjectProvider({required this.getTeamProjectsUseCase});

  List<TeamProjectEntity> _projects = [];
  bool _isLoading = false;
  String? _error;

  List<TeamProjectEntity> get projects => _projects;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchTeamProjects(String webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await getTeamProjectsUseCase(webUserId);
      _projects = data;
      AppLoggerHelper.logInfo('✅ Team projects fetched: ${_projects.length}');
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError('❌ Failed to fetch team projects: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _projects = [];
    _error = null;
    notifyListeners();
  }
}
