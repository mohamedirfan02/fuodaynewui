

import 'package:fuoday/features/ats_candidate/data/datasource/remote/candidates_remote_datasource.dart';
import 'package:fuoday/features/ats_candidate/data/models/candidate_action_model.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_action_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/repository/candidates_action.dart';

class CandidatesActionRepositoryImpl implements CandidatesActionRepository {
  final CandidatesActionRemoteDataSource remoteDataSource;

  CandidatesActionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> actionOnCandidate(CandidateActionEntity entity) async {
    final model = CandidateActionModel.fromEntity(entity);
    return await remoteDataSource.actionOnCandidate(model.toJson());
  }
}
