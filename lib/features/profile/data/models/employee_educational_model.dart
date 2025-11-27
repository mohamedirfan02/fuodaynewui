class EducationModel {
  final String university;
  final String qualification;
  final String yearOfPassing;

  EducationModel({
    required this.university,
    required this.qualification,
    required this.yearOfPassing,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      university: json['university'],
      qualification: json['qualification'],
      yearOfPassing: json['year_of_passing'],
    );
  }
}

class SkillModel {
  final String skill;

  SkillModel({required this.skill});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(skill: json['skill']);
  }
}
