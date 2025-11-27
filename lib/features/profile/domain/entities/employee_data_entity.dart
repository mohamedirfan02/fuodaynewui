class EmployeeEntity {
  final String message;
  final String status;
  final EmployeeDataEntity data;

  EmployeeEntity({
    required this.message,
    required this.status,
    required this.data,
  });
}

class EmployeeDataEntity {
  final String? place;
  final String? designation;
  final String? department;
  final String? employmentType;
  final String? reportingManagerId;
  final String? reportingManagerName;
  final String? about; // ✅ Nullable
  final String? dob;
  final String? address; // ✅ Already nullable
  final String? dateOfJoining;
  final String? profilePhoto; // ✅ Nullable
  final String? name;
  final String? email;
  final String? personalContactNo;
  final String? empId;
  final List<ExperienceEntity> experiences;

  // final List<SkillEntity> skills;
  // final List<EducationEntity> education;
  final List<OnboardingEntity> onboardings;
  final ReferredSummaryEntity referredSummary;

  EmployeeDataEntity({
    this.place,
    this.designation,
    this.department,
    this.employmentType,
    this.reportingManagerId,
    this.reportingManagerName,
    this.about,
    this.dob,
    this.address,
    this.dateOfJoining,
    this.profilePhoto,
    this.name,
    this.email,
    this.personalContactNo,
    this.empId,
    required this.experiences,
    required this.onboardings,
    required this.referredSummary,
  });
}

class ExperienceEntity {
  // Define fields later if needed
  ExperienceEntity();
}

class OnboardingEntity {
  // Define fields later if needed
  OnboardingEntity();
}

class ReferredSummaryEntity {
  final int total;
  final int? selected;
  final int? onboarded;

  ReferredSummaryEntity({required this.total, this.selected, this.onboarded});
}
