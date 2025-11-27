

import 'package:fuoday/features/team_tree/data/datasource/team_tree_remote_data_source.dart';
import 'package:fuoday/features/team_tree/domain/entities/team_tree_entity.dart';
import 'package:fuoday/features/team_tree/domain/repository/team_tree_repository.dart';

class TeamTreeRepositoryImpl implements TeamTreeRepository {
  final TeamTreeRemoteDataSource remoteDataSource;

  TeamTreeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TeamTreeEntity>> getTeamTree(int webUserId) async {
    final models = await remoteDataSource.getTeamTree(webUserId);
    return models
        .map(
          (m) => TeamTreeEntity(
        managerId: m.managerId,
        managerName: m.managerName,
        employees: m.employees
            .map(
              (e) => EmployeeEntity(
            id: e.id,
            empName: e.empName,
            empId: e.empId,
            designation: e.designation,
            department: e.department,
            doj: e.doj,
            profilePhoto: e.profilePhoto,
            status: e.status,
          ),
        )
            .toList(),
      ),
    )
        .toList();
  }
}
