import 'package:fuoday/features/organizations/domain/entities/DepartmentMemberEntity.dart';
import 'package:fuoday/features/organizations/domain/repositories/DepartmentListRepository.dart';

class GetDepartmentListUseCase {
  final DepartmentListRepository repository;

  GetDepartmentListUseCase(this.repository);

  Future<Map<String, List<DepartmentMemberEntity>>> call(String webUserId) async {
    return await repository.getDepartmentList(webUserId);
  }
}
