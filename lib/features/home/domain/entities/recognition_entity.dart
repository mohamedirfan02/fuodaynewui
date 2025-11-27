class RecognitionEntity {
  final String? id;
  final String title;
  final int count;
  final String? imageUrl; // From API if exists

  RecognitionEntity({
    this.id,
    required this.title,
    required this.count,
    this.imageUrl,
  });
}
