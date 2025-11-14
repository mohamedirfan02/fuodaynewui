

import 'package:fuoday/features/ats_candidate/domain/entities/candidate_action_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/repository/candidates_action.dart';

class ActionOnCandidateUseCase {
  final CandidatesActionRepository repository;

  ActionOnCandidateUseCase({required this.repository});

  Future<bool> call(CandidateActionEntity entity) async {
    return await repository.actionOnCandidate(entity);
  }
}
