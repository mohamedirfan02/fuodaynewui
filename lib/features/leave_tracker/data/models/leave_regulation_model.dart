
import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';

class LeaveRegulationModel extends LeaveRegulationEntity {
  const LeaveRegulationModel({
    required super.webUserId,
    required super.fromDate,
    required super.toDate,
    required super.reason,
    required super.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      "web_user_id": webUserId,
      "from": fromDate,
      "to": toDate,
      "regulation_reason": reason,
      "regulation_comment": comment,
    };
  }
}
