/*
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/support/data/models/ticket_model.dart';


class TicketRemoteDataSource {
  final DioService dio;

  TicketRemoteDataSource(this.dio);

  Future<void> createTicket(TicketModel model) async {
    final response = await dio.client.post(
      AppApiEndpointConstants.createTicket,
      data: model.toJson(),
    );

    if (response.statusCode! >= 400) {
      throw Exception('❌ Failed to create ticket: ${response.data}');
    }
  }
}
*/
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/support/data/models/ticket_model.dart';

class TicketRemoteDataSource {
  final DioService dio;

  TicketRemoteDataSource(this.dio);

  Future<void> createTicket(TicketModel model) async {
    try {
      final response = await dio.client.post(
        AppApiEndpointConstants.createTicket,
        data: model.toJson(),
      );

      //   Added safe response handling here
      if (response.statusCode == null || response.statusCode! >= 400) {
        throw Exception('❌ Failed to create ticket: ${response.data}');
      }

      //   Ensure response.data is a Map (avoids List<Map> or null type issues)
      if (response.data is! Map<String, dynamic>) {
        throw Exception(
          '⚠️ Unexpected response format: ${response.data.runtimeType}',
        );
      }
    } catch (e) {
      //   Catching Dio/Type/Format errors safely
      throw Exception('❌ Error while creating ticket: $e');
    }
  }
}
