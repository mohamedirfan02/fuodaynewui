import 'package:flutter/material.dart';
import 'package:fuoday/features/ats_candidate/domain/entities/candidate_entity.dart';
import 'package:fuoday/features/ats_candidate/domain/usecase/get_candidates_usecase.dart';

enum CandidatesStatus { initial, loading, success, error }

class CandidatesProvider extends ChangeNotifier {
  final GetCandidatesUseCase getCandidatesUseCase;

  CandidatesProvider({required this.getCandidatesUseCase});

  CandidatesStatus _status = CandidatesStatus.initial;
  List<CandidateEntity> _candidates = [];
  CountsEntity? _counts;
  String _errorMessage = '';

  CandidatesStatus get status => _status;
  List<CandidateEntity> get candidates => _candidates;
  CountsEntity? get counts => _counts;
  String get errorMessage => _errorMessage;

  Future<void> fetchCandidates(String webUserId) async {
    _status = CandidatesStatus.loading;
    notifyListeners();

    final result = await getCandidatesUseCase(webUserId);

    result.fold(
          (error) {
        _status = CandidatesStatus.error;
        _errorMessage = error;
        notifyListeners();
      },
          (response) {
        _status = CandidatesStatus.success;
        _candidates = response.candidates;
        _counts = response.counts;
        notifyListeners();
      },
    );
  }

  void reset() {
    _status = CandidatesStatus.initial;
    _candidates = [];
    _counts = null;
    _errorMessage = '';
    notifyListeners();
  }
}