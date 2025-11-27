import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/teams/domain/entities/team_reportees_entity.dart';
import 'package:fuoday/features/teams/domain/usecases/get_team_reportees_usecase.dart';

class TeamReporteesProvider extends ChangeNotifier {
  final GetTeamReporteesUseCase getTeamReporteesUseCase;

  TeamReporteesProvider({required this.getTeamReporteesUseCase});

  List<TeamReporteesEntity> _reportees = [];
  bool _isLoading = false;
  String? _error;

  List<TeamReporteesEntity> get reportees => _reportees;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchReportees(String webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await getTeamReporteesUseCase(webUserId);
      _reportees = data;
      AppLoggerHelper.logInfo('✅ Reportees fetched: ${data.length}');
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError('❌ Failed to fetch reportees: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _reportees = [];
    _error = null;
    notifyListeners();
  }
}
