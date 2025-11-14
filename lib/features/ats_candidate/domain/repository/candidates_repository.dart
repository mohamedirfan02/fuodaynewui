import 'package:dartz/dartz.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';

abstract class CandidatesRepository {
  Future<Either<String, CandidatesResponse>> getCandidates(String webUserId);
}