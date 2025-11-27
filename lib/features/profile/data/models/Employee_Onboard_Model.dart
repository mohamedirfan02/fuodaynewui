import 'package:dio/dio.dart';

class EmployeeOnboardModel {
  final int webUserId;
  final String? welcomeEmailSent;
  final String? scheduledDate;
  final MultipartFile? photo;
  final MultipartFile? pan;
  final MultipartFile? passbook;
  final MultipartFile? payslip;
  final MultipartFile? offerLetter;

  EmployeeOnboardModel({
    required this.webUserId,
    this.welcomeEmailSent,
    this.scheduledDate,
    this.photo,
    this.pan,
    this.passbook,
    this.payslip,
    this.offerLetter,
  });

  FormData toFormData() {
    final map = <String, dynamic>{
      'web_user_id': webUserId.toString(),
      if (welcomeEmailSent != null) 'welcome_email_sent': welcomeEmailSent,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (photo != null) 'photo': photo,
      if (pan != null) 'pan': pan,
      if (passbook != null) 'passbook': passbook,
      if (payslip != null) 'payslip': payslip,
      if (offerLetter != null) 'offer_letter': offerLetter,
    };
    return FormData.fromMap(map);
  }
}
