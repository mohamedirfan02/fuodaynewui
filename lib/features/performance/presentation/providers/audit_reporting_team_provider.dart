import 'package:flutter/cupertino.dart';
import 'package:fuoday/features/performance/domain/entities/audit_reporting_team_entity.dart';
import 'package:fuoday/features/performance/domain/usecases/get_audit_reporting_team_usecase.dart';

class AuditReportingTeamProvider extends ChangeNotifier {
  final GetAuditReportingTeamUseCase getAuditReportingTeamUseCase;

  AuditReportingTeamProvider({required this.getAuditReportingTeamUseCase});

  bool _isLoading = false;
  String? _error;
  List<AuditReportingTeamEntity> _team = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<AuditReportingTeamEntity> get team => _team;

  Future<void> fetchAuditReportingTeam(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await getAuditReportingTeamUseCase(webUserId);
      _team = result;
    } catch (e, stack) {
      _error = e.toString();
      debugPrint("❌ fetchAuditReportingTeam error: $e\n$stack");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
