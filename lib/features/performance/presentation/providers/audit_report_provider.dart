import 'package:flutter/foundation.dart';
import 'package:fuoday/features/performance/domain/entities/audit_report_entity.dart';
import 'package:fuoday/features/performance/domain/usecases/get_audit_report_usecase.dart';


class AuditReportProvider with ChangeNotifier {
  final GetAuditReportUseCase getAuditReportUseCase;

  AuditReportProvider({required this.getAuditReportUseCase});

  bool isLoading = false;
  String? error;
  AuditReportEntity? auditReport;

  // Add method to clear audit report data
  void clearAuditReport() {
    auditReport = null;
    error = null;
    notifyListeners();
  }

  Future<void> fetchAuditReport(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      auditReport = await getAuditReportUseCase(id);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
