import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/features/home/data/model/event_model.dart';

class EventsRemoteDataSource {
  final DioService dioService;
  final HiveStorageService hiveStorageService;
  final SecureStorageService secureStorageService;

  EventsRemoteDataSource({
    required this.dioService,
    required this.hiveStorageService,
    required this.secureStorageService,
  });

  String get _webUserId {
    final id = hiveStorageService.employeeDetails?['web_user_id'];
    if (id == null) throw Exception('Web User ID not found in Hive storage');
    return id.toString();
  }

  Future<void> _injectAuthToken() async {
    final token = await secureStorageService.getToken();
    if (token == null) throw Exception('Auth token not found');
    dioService.updateAuthToken(token); // inject the token into Dio header
  }

  Future<List<EventModel>> fetchAnnouncement() async {
    await _injectAuthToken();

    final response = await dioService.get(
      AppApiEndpointConstants.announcements(_webUserId),
    );

    if (response.statusCode == 200 && response.data['data'] is List) {
      return (response.data['data'] as List)
          .map((item) => EventModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch announcements');
    }
  }

  Future<List<EventModel>> fetchCelebrations() async {
    await _injectAuthToken();

    final response = await dioService.get(
      AppApiEndpointConstants.celebrations(_webUserId),
    );

    if (response.statusCode == 200 && response.data['data'] is List) {
      return (response.data['data'] as List)
          .map((item) => EventModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch celebrations');
    }
  }

  Future<List<EventModel>> fetchOrganizationalPrograms() async {
    await _injectAuthToken();

    final response = await dioService.get(
      AppApiEndpointConstants.organizationalPrograms(_webUserId),
    );

    if (response.statusCode == 200 && response.data['data'] is List) {
      return (response.data['data'] as List)
          .map((item) => EventModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to fetch organizational programs');
    }
  }
}
