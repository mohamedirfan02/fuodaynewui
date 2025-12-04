import 'package:flutter/material.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';

class DraftProvider extends ChangeNotifier {
  final HiveStorageService hiveStorage;

  DraftProvider(this.hiveStorage);

  List<Map<String, dynamic>> draftList = [];

  /// Save new draft
  void saveDraft(Map<String, dynamic> data) {
    draftList.add(data);
    hiveStorage.saveDraftList(draftList); // store entire list in Hive
    notifyListeners();
  }

  /// Load draft list
  Future<void> loadDraft() async {
    draftList = await hiveStorage.getDraftList() ?? [];
    notifyListeners();
  }

  /// Delete one draft by index (keep for backward compatibility)
  void deleteDraft(int index) {
    if (index >= 0 && index < draftList.length) {
      draftList.removeAt(index);
      hiveStorage.saveDraftList(draftList);
      notifyListeners();
    }
  }

  /// Delete one draft by Job ID (safe)
  void deleteDraftById(String jobId) {
    draftList.removeWhere((draft) => draft['Job ID'] == jobId);
    hiveStorage.saveDraftList(draftList);
    notifyListeners();
  }

  /// Clear all drafts
  void clearAll() {
    draftList = [];
    hiveStorage.clearDraftList();
    notifyListeners();
  }
}
