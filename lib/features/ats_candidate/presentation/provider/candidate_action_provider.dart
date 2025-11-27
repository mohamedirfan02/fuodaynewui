import 'package:flutter/material.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_action_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/usecase/action_on_candidate_usecase.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/di/injection.dart';

class CandidateActionProvider extends ChangeNotifier {
  final ActionOnCandidateUseCase actionOnCandidateUseCase;

  bool isLoading = false;

  CandidateActionProvider({required this.actionOnCandidateUseCase});

  Future<bool> deleteCandidate(int candidateId) async {
    isLoading = true;
    notifyListeners();

    // Read web_user_id from Hive
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserIdRaw = employeeDetails?['web_user_id'];
    final int webUserId = int.tryParse(webUserIdRaw.toString()) ?? 0;


    final entity = CandidateActionEntity(
      action: "delete",
      webUserId: webUserId,
      id: candidateId,
    );

    final result = await actionOnCandidateUseCase(entity);

    isLoading = false;
    notifyListeners();

    return result;
  }
}
