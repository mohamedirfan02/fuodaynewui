

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/performance/data/models/audit_report_model.dart';

abstract class AuditReportRemoteDataSource {
  Future<AuditReportModel> getEachPersonAuditForm(int id);
}

class AuditReportRemoteDataSourceImpl implements AuditReportRemoteDataSource {
  final DioService dioService;

  AuditReportRemoteDataSourceImpl(this.dioService);

  @override
  Future<AuditReportModel> getEachPersonAuditForm(int id) async {
    final response = await dioService.get("/hrms/performance/getauditreport/$id");
    final data = response.data['data'];
    return AuditReportModel.fromJson(data);
  }
}
