
import 'package:fuoday/features/home/domain/entities/badge_entity.dart';

class BadgeModel extends BadgeEntity {
  BadgeModel({
    required int id,
    required int webUserId,
    required String title,
    required int count,
    required String imageUrl,
    required String createdAt,
    required String updatedAt,
  }) : super(
    id: id,
    webUserId: webUserId,
    title: title,
    count: count,
    imageUrl: imageUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      title: json['title'],
      count: json['count'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'web_user_id': webUserId,
      'title': title,
      'count': count,
      'image_url': imageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
