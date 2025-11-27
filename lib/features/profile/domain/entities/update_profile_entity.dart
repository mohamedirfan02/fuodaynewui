import 'dart:io';

class UpdateProfileEntity {
  final String webUserId;
  final String? firstName;
  final String? lastName;
  final String? about;
  final String? dob;
  final String? address;
  final String? phone;
  final File? profileImageFile; // Optional image path

  UpdateProfileEntity({
    required this.webUserId,
    this.firstName,
    this.lastName,
    this.about,
    this.dob,
    this.address,
    this.phone,
    this.profileImageFile,
  });
}
