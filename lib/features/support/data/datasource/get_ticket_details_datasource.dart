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
*/ /*

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

    if (resp.statusCode! >= 400) {
      throw Exception("Error: ${resp.statusCode}");
    }

    final raw = resp.data;

    //   SAFETY LAYER 1: Ensure we actually have a Map
    if (raw is! Map<String, dynamic>) {
      print('  raw is not a Map, returning empty');
      return {};
    }

    final data = raw['data'];

    //   SAFETY LAYER 2: data can be List or null
    if (data == null || data is! Map<String, dynamic>) {
      print('  data is null or not a Map, returning empty');
      return {};
    }

    final groupedRaw = data['groupedTickets'];

    //   SAFETY LAYER 3: groupedTickets can be missing or list
    if (groupedRaw == null || groupedRaw is List) {
      print('  groupedTickets missing or list, returning empty');
      return {};
    }

    //   SAFETY LAYER 4: Still not a Map? Empty.
    if (groupedRaw is! Map<String, dynamic>) {
      print('  groupedTickets is not a Map, returning empty');
      return {};
    }

    final grouped = Map<String, dynamic>.from(groupedRaw);

    //   Only keep needed keys: assigned, unassigned, completed
    final result = <String, List<GetTicketDetailsModel>>{};
    for (final key in ['assigned', 'unassigned', 'completed']) {
      final value = grouped[key];

      if (value is List) {
        try {
          final list = value
              .whereType<Map<String, dynamic>>()
              .map((e) => GetTicketDetailsModel.fromJson(e))
              .toList();
          result[key] = list;
        } catch (e) {
          print('  Error parsing $key: $e');
          result[key] = [];
        }
      } else {
        result[key] = [];
      }
    }

    //   Debugging — to confirm what structure we got
    print('  Final grouped keys: ${result.keys}');
    return result;
  }
}
