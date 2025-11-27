import 'package:fuoday/features/organizations/data/datasources/remote/departmentListRemoteDataSource.dart';
import 'package:fuoday/features/organizations/domain/entities/DepartmentMemberEntity.dart';
import 'package:fuoday/features/organizations/domain/repositories/DepartmentListRepository.dart';

class DepartmentListRepositoryImpl implements DepartmentListRepository {
  final DepartmentListRemoteDataSource remoteDataSource;

  DepartmentListRepositoryImpl(this.remoteDataSource);

  @override
  Future<Map<String, List<DepartmentMemberEntity>>> getDepartmentList(String webUserId) async {
    final rawData = await remoteDataSource.fetchDepartmentList(webUserId);
    return rawData.map((key, value) => MapEntry(
      key,
      value.map((e) => DepartmentMemberEntity(
        webUserId: e.webUserId,
        name: e.name,
        empId: e.empId,
        email: e.email,
        role: e.role,
        department: e.department,
        designation: e.designation,
      )).toList(),
    ));
  }
}
