class TeamReporteesEntity {
  final int id;
  final String name;
  final String designation;
  final String? profile;
  final String department;
  final int parentId;

  TeamReporteesEntity({
    required this.id,
    required this.name,
    required this.designation,
    required this.profile,
    required this.department,
    required this.parentId,
  });
}
