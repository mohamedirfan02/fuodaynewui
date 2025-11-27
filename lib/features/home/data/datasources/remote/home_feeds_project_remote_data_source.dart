import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/home/data/model/home_feeds_project_data_model.dart';


class HomeFeedsProjectRemoteDataSource {
  final DioService dio;

  HomeFeedsProjectRemoteDataSource(this.dio);

  Future<HomeFeedsProjectDataModel> getFeeds(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.feedData(webUserId));
    return HomeFeedsProjectDataModel.fromJson(response.data['data']);
  }
}
