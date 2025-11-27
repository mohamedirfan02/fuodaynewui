
import 'package:fuoday/features/profile/domain/entities/profile_professional_experience_entity.dart';

class ProfessionalExperienceModel extends ProfessionalExperienceEntity {
  const ProfessionalExperienceModel({
    required String companyName,
    required String noOfYears,
    required String role,
    required String duration,
    required String responsibilities,
    required String achievements,
  }) : super(
    companyName: companyName,
    noOfYears: noOfYears,
    role: role,
    duration: duration,
    responsibilities: responsibilities,
    achievements: achievements,
  );

  Map<String, dynamic> toJson(int webUserId) => {
    "web_user_id": webUserId,
    "company_name": companyName,
    "no_of_yrs": noOfYears,
    "role": role,
    "duration": duration,
    "responsibilities": responsibilities,
    "achievements": achievements,
  };
}
