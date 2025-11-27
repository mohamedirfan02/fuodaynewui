import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/ats_candidate/data/models/candidate_model.dart';

abstract class CandidatesRemoteDataSource {
  Future<CandidatesResponseModel> getCandidates(String webUserId);
}

class CandidatesRemoteDataSourceImpl implements CandidatesRemoteDataSource {
  final DioService dioService;

  CandidatesRemoteDataSourceImpl({required this.dioService});

  @override
  Future<CandidatesResponseModel> getCandidates(String webUserId) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getCandidates(webUserId),
      );

      if (response.statusCode == 200) {
        return CandidatesResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch candidates: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}