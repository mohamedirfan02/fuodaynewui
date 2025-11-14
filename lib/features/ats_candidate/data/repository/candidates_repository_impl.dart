

import 'package:dartz/dartz.dart';
import 'package:fuoday/features/ats_candidate/data/datasource/remote/candidates_remote_data_source.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/repository/candidates_repository.dart';

class CandidatesRepositoryImpl implements CandidatesRepository {
  final CandidatesRemoteDataSource remoteDataSource;

  CandidatesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, CandidatesResponse>> getCandidates(
      String webUserId) async {
    try {
      final response = await remoteDataSource.getCandidates(webUserId);

      final candidates = response.candidates
          .map((model) => model.toEntity())
          .toList();

      final counts = response.counts.toEntity();

      return Right(
        CandidatesResponse(
          candidates: candidates,
          counts: counts,
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}