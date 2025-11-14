import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';

abstract class CandidatesActionRemoteDataSource {
  Future<bool> actionOnCandidate(Map<String, dynamic> body);
}
class CandidatesActionRemoteDataSourceImpl implements CandidatesActionRemoteDataSource {
  final DioService dioService;

  CandidatesActionRemoteDataSourceImpl({required this.dioService});

  @override
  Future<bool> actionOnCandidate(Map<String, dynamic> body) async {
    final response = await dioService.post(
      AppApiEndpointConstants.candidateActions,
      data: body,
    );

    return response.data["success"] == true;
  }
}