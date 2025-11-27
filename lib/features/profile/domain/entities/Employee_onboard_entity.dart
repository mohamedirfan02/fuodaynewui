import 'dart:io';

class EmployeeOnboardEntity {
  final int webUserId;
  final DateTime? welcomeEmailSent;
  final DateTime? scheduledDate;
  final File? photo;
  final File? pan;
  final File? passbook;
  final File? payslip;
  final File? offerLetter;

  EmployeeOnboardEntity({
    required this.webUserId,
    this.welcomeEmailSent,
    this.scheduledDate,
    this.photo,
    this.pan,
    this.passbook,
    this.payslip,
    this.offerLetter,
  });
}
