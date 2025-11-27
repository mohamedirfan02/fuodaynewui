import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_punctual_arrivals_details_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<TotalPunctualArrivalsDetailsModel> getTotalPunctualArrivalDetails(int webUserId);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioService dioService;

  AttendanceRemoteDataSourceImpl({required this.dioService});

  @override
  Future<TotalPunctualArrivalsDetailsModel> getTotalPunctualArrivalDetails(int webUserId) async {
    try {
      print('🔍 DataSource: Fetching punctual arrivals for webUserId: $webUserId');

      final response = await dioService.get('/hrms/attendance/punctual-arrivals/$webUserId');

      print('🔍 DataSource: API response status: ${response.statusCode}');
      print('🔍 DataSource: API response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200 || response.statusCode == null) {
        final jsonData = response.data as Map<String, dynamic>;

        final model = TotalPunctualArrivalsDetailsModel.fromJson(jsonData);

        print('✅ DataSource: Model parsed successfully');
        return model;
      } else {
        throw Exception('API call failed with status: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('❌ DataSource Error: $e');
      print(stackTrace);
      rethrow;
    }
  }
}
