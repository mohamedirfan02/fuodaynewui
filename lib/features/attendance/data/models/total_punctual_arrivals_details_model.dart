// File: features/attendance/data/models/total_punctual_arrivals_details_model.dart

import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';

class TotalPunctualArrivalsDetailsModel extends TotalPunctualArrivalsDetailsEntity {
  TotalPunctualArrivalsDetailsModel({
    super.message,
    super.status,
    PunctualDataModel? super.data,
  });

  factory TotalPunctualArrivalsDetailsModel.fromJson(Map<String, dynamic> json) {
    print('🔍 TotalPunctualArrivalsDetailsModel.fromJson received: $json');

    try {
      final model = TotalPunctualArrivalsDetailsModel(
        message: json['message']?.toString(),
        status: json['status']?.toString(),
        data: json['data'] != null
            ? PunctualDataModel.fromJson(json['data'] as Map<String, dynamic>)
            : null,
      );

      print('✅ Successfully created TotalPunctualArrivalsDetailsModel');
      print('✅ Message: ${model.message}');
      print('✅ Status: ${model.status}');
      print('✅ Has data: ${model.data != null}');

      return model;
    } catch (e, stackTrace) {
      print('❌ Error in TotalPunctualArrivalsDetailsModel.fromJson: $e');
      print('❌ Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'data': (data as PunctualDataModel?)?.toJson(),
  };
}

class PunctualDataModel extends PunctualDataEntity {
  PunctualDataModel({
    super.employeeName,
    super.totalPunctualArrivals,
    super.recordsUpdated,
    super.punctualArrivalPercentage,
    List<PunctualArrivalRecordModel>? super.punctualArrivalsDetails,
  });

  factory PunctualDataModel.fromJson(Map<String, dynamic> json) {
    print('🔍 PunctualDataModel.fromJson received: $json');

    try {
      // Parse punctual arrivals details
      List<PunctualArrivalRecordModel> punctualDetails = [];

      if (json['punctual_arrivals_details'] != null) {
        final detailsList = json['punctual_arrivals_details'] as List;
        print('🔍 Processing ${detailsList.length} punctual records');

        punctualDetails = detailsList
            .map((e) => PunctualArrivalRecordModel.fromJson(e as Map<String, dynamic>))
            .toList();

        print('✅ Successfully parsed ${punctualDetails.length} punctual records');
      }

      // Parse percentage as double
      double? percentage;
      if (json['punctual_arrival_percentage'] != null) {
        final percentageValue = json['punctual_arrival_percentage'];
        if (percentageValue is int) {
          percentage = percentageValue.toDouble();
        } else if (percentageValue is double) {
          percentage = percentageValue;
        } else if (percentageValue is String) {
          percentage = double.tryParse(percentageValue);
        }
      }

      final model = PunctualDataModel(
        employeeName: json['employee_name']?.toString(),
        totalPunctualArrivals: json['total_punctual_arrivals'] as int?,
        recordsUpdated: json['records_updated'] as int?,
        punctualArrivalPercentage: percentage,
        punctualArrivalsDetails: punctualDetails,
      );

      print('✅ Successfully created PunctualDataModel');
      print('✅ Employee Name: ${model.employeeName}');
      print('✅ Total Punctual: ${model.totalPunctualArrivals}');
      print('✅ Percentage: ${model.punctualArrivalPercentage}');
      print('✅ Records count: ${model.punctualArrivalsDetails?.length}');

      return model;
    } catch (e, stackTrace) {
      print('❌ Error in PunctualDataModel.fromJson: $e');
      print('❌ Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    'employee_name': employeeName,
    'total_punctual_arrivals': totalPunctualArrivals,
    'records_updated': recordsUpdated,
    'punctual_arrival_percentage': punctualArrivalPercentage,
    'punctual_arrivals_details': punctualArrivalsDetails
        ?.map((e) => (e as PunctualArrivalRecordModel).toJson())
        .toList(),
  };
}

class PunctualArrivalRecordModel extends PunctualArrivalRecordEntity {
  PunctualArrivalRecordModel({
    super.date,
    super.empName,
    super.checkinTime,
    super.punctualTime,
    super.currentStatus,
  });

  factory PunctualArrivalRecordModel.fromJson(Map<String, dynamic> json) {
    print('🔍 PunctualArrivalRecordModel.fromJson received: $json');

    try {
      final model = PunctualArrivalRecordModel(
        date: json['date']?.toString(),
        empName: json['emp_name']?.toString(),
        checkinTime: json['checkin_time']?.toString(),
        punctualTime: json['punctual_time']?.toString(),
        currentStatus: json['current_status']?.toString(),
      );

      print('✅ Successfully created PunctualArrivalRecordModel: ${model.empName} - ${model.date}');

      return model;
    } catch (e, stackTrace) {
      print('❌ Error in PunctualArrivalRecordModel.fromJson: $e');
      print('❌ Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'emp_name': empName,
    'checkin_time': checkinTime,
    'punctual_time': punctualTime,
    'current_status': currentStatus,
  };
}