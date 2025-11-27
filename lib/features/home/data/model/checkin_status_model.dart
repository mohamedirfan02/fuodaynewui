class CheckinStatusModel {
  final String? checkin;
  final String? checkout;
  final String? location;

  CheckinStatusModel({
    this.checkin,
    this.checkout,
    this.location,
  });

  factory CheckinStatusModel.fromJson(Map<String, dynamic> json) {
    return CheckinStatusModel(
      checkin: json['checkin'] as String?,
      checkout: json['checkout'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkin': checkin,
      'checkout': checkout,
      'location': location,
    };
  }
}

class CheckinStatusResponse {
  final String message;
  final String status;
  final CheckinStatusModel data;

  CheckinStatusResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory CheckinStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckinStatusResponse(
      message: json['message'] as String,
      status: json['status'] as String,
      data: CheckinStatusModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}