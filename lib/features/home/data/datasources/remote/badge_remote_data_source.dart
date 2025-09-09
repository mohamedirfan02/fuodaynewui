
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/home/data/model/badge_model.dart';

abstract class BadgeRemoteDataSource {
  Future<List<BadgeModel>> getBadges(int webUserId);
}

class BadgeRemoteDataSourceImpl implements BadgeRemoteDataSource {
  final DioService dioService;

  BadgeRemoteDataSourceImpl(this.dioService);

  @override
  Future<List<BadgeModel>> getBadges(int webUserId) async {
    final response = await dioService.get('/hrms/home/recognitions/$webUserId');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data['data'] as List;
      return data.map((json) => BadgeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch badges');
    }
  }
}
