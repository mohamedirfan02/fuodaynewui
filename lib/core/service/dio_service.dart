import 'package:dio/dio.dart';
import 'package:fuoday/config/flavors/flavors_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  factory DioService() => _instance;

  late Dio _dio;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getIt<SecureStorageService>().getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Dio get client => _dio;

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  Future<Response> post(
      String endpoint, {
        dynamic data,
        Options? options,
      }) async {
    try {
      // If data is FormData, set content-type for file upload
      if (data is FormData) {
        options = Options(
          contentType: 'multipart/form-data',
          headers: _dio.options.headers,
        );
      }

      return await _dio.post(endpoint, data: data, options: options);
    } on DioException catch (e) {
      throw handleError(e);
    }
  }


  dynamic handleError(DioException e) {
    if (e.response != null) {
      debugPrint("Dio error response: ${e.response?.data}");
      return e.response?.data ?? 'Unknown error';
    } else {
      return 'Network error: ${e.message}';
    }
  }

  void updateAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
