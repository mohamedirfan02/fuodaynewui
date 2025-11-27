class EmployeeAuthEntity {
  final String status;
  final String message;
  final EmployeeDataEntity data;
  final String token;

  const EmployeeAuthEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });
}

class EmployeeDataEntity {
  final String? webUserId;
  final int adminUserId;
  final String name;
  final String email;
  final String role;
  final String empId;
  final String? group;
  final String createdAt;
  final String updatedAt;
  final String? checkin;
  final EmployeeDetailsEntity employeeDetails;
  final AdminUserEntity adminUser;

  const EmployeeDataEntity({
    required this.webUserId,
    required this.adminUserId,
    required this.name,
    required this.email,
    required this.role,
    required this.empId,
    required this.group,
    required this.createdAt,
    required this.updatedAt,
    required this.checkin,
    required this.employeeDetails,
    required this.adminUser,
  });
}

class EmployeeDetailsEntity {
  final int webUserId;
  final String? profilePhoto;
  final String designation;
  final String department;
  final String? checkin;
  final String? access;

  const EmployeeDetailsEntity({
    required this.webUserId,
    required this.profilePhoto,
    required this.designation,
    required this.department,
    required this.checkin,
    required this.access,
  });
}

class AdminUserEntity {
  final int id;
  final String logo;
  final String brandLogo;
  final String companyName;
  final String chatLogo;
  final String companyWord;

  const AdminUserEntity({
    required this.id,
    required this.logo,
    required this.brandLogo,
    required this.companyName,
    required this.chatLogo,
    required this.companyWord,
  });
}

// forgot_password_entity.dart
class ForgotPasswordDebugEntity {
  final String otp;
  final String email;
  final String mailDriver;

  const ForgotPasswordDebugEntity({
    required this.otp,
    required this.email,
    required this.mailDriver,
  });
}

class ForgotPasswordEntity {
  final String status;
  final String message;
  final ForgotPasswordDebugEntity debug;

  const ForgotPasswordEntity({
    required this.status,
    required this.message,
    required this.debug,
  });
}

class VerifyOtpEntity {
  final String status;
  final String message;

  const VerifyOtpEntity({required this.status, required this.message});
}

class ResetPasswordEntity {
  final String status;
  final String message;

  ResetPasswordEntity({required this.status, required this.message});
}
