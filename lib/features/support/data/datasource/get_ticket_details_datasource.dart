/*


import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/support/data/models/get_ticket_details_model.dart';

abstract class GetTicketDetailsDataSource {
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(int webUserId);
}

class GetTicketDetailsDataSourceImpl implements GetTicketDetailsDataSource {
  final DioService dio;
  GetTicketDetailsDataSourceImpl(this.dio);

  @override
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(int webUserId) async {
    final resp = await dio.client.get(AppApiEndpointConstants.getTicketsDetails(webUserId));
    if (resp.statusCode! >= 400) throw Exception("Error: ${resp.statusCode}");
    final grouped = resp.data['data']['groupedTickets'] as Map<String, dynamic>;
    return grouped.map((k, v) => MapEntry(
      k,
      (v as List)
          .map((e) => GetTicketDetailsModel.fromJson(e))
          .toList(),
    ));
  }
}
*/
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/support/data/models/get_ticket_details_model.dart';

abstract class GetTicketDetailsDataSource {
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(int webUserId);
}

class GetTicketDetailsDataSourceImpl implements GetTicketDetailsDataSource {
  final DioService dio;
  GetTicketDetailsDataSourceImpl(this.dio);

  @override
  Future<Map<String, List<GetTicketDetailsModel>>> fetchTickets(
    int webUserId,
  ) async {
    final resp = await dio.client.get(
      AppApiEndpointConstants.getTicketsDetails(webUserId),
    );

    if (resp.statusCode! >= 400) throw Exception("Error: ${resp.statusCode}");

    //   FIX: handle cases when resp.data['data'] or groupedTickets are null or not a map
    final data = resp.data['data'];

    if (data == null) {
      //   return empty map when no data
      return {};
    }

    final groupedRaw = data['groupedTickets'];

    if (groupedRaw == null) {
      //   empty groupedTickets
      return {};
    }

    if (groupedRaw is List) {
      //   handle when API returns [] instead of {}
      if (groupedRaw.isEmpty) return {};
      // Optional: try converting if list actually contains maps
      try {
        return {
          "default": groupedRaw
              .map((e) => GetTicketDetailsModel.fromJson(e))
              .toList(),
        };
      } catch (_) {
        return {};
      }
    }

    if (groupedRaw is! Map<String, dynamic>) {
      //   unexpected format
      return {};
    }

    final grouped = groupedRaw as Map<String, dynamic>;

    //   safely map values
    return grouped.map((k, v) {
      final list = (v is List)
          ? v.map((e) => GetTicketDetailsModel.fromJson(e)).toList()
          : <GetTicketDetailsModel>[];
      return MapEntry(k, list);
    });
  }
}
