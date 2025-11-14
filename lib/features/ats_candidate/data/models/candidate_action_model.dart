
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_action_entity.dart';

class CandidateActionModel extends CandidateActionEntity {
  CandidateActionModel({
    required super.action,
    required super.webUserId,
    required super.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "action": action,
      "web_user_id": webUserId,
      "id": id,
    };
  }

  factory CandidateActionModel.fromEntity(CandidateActionEntity entity) {
    return CandidateActionModel(
      action: entity.action,
      webUserId: entity.webUserId,
      id: entity.id,
    );
  }
}
