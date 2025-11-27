class BadgeEntity {
  final int id;
  final int webUserId;
  final String title;
  final int count;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  BadgeEntity({
    required this.id,
    required this.webUserId,
    required this.title,
    required this.count,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
