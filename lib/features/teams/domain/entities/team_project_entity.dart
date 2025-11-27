class TeamProjectEntity {
  final String name;
  final String domain;
  final String deadline;
  final List<TeamProjectMemberEntity> teamMembers;

  TeamProjectEntity({
    required this.name,
    required this.domain,
    required this.deadline,
    required this.teamMembers,
  });
}

class TeamProjectMemberEntity {
  final String name;
  final String role;

  TeamProjectMemberEntity({
    required this.name,
    required this.role,
  });
}
