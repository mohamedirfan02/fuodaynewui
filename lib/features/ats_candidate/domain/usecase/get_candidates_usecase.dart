import 'package:dartz/dartz.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/repository/candidates_repository.dart';

class GetCandidatesUseCase {
  final CandidatesRepository repository;

  GetCandidatesUseCase({required this.repository});

  Future<Either<String, CandidatesResponse>> call(String webUserId) async {
    return await repository.getCandidates(webUserId);
  }
}