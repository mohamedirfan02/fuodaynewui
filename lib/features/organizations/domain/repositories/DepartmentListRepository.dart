import 'package:fuoday/features/organizations/domain/entities/DepartmentMemberEntity.dart';

abstract class DepartmentListRepository {
  Future<Map<String, List<DepartmentMemberEntity>>> getDepartmentList(String webUserId);
}
