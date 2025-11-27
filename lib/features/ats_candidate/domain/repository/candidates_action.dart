import 'package:fuoday/features/ats_candidate/domain/entities/candidate_action_entity.dart';

abstract class CandidatesActionRepository {
  Future<bool> actionOnCandidate(CandidateActionEntity entity);
}
