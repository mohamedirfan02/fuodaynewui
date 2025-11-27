import 'package:flutter/material.dart';
import 'package:fuoday/features/team_tree/domain/entities/team_tree_entity.dart';
import 'package:fuoday/features/team_tree/domain/usecase/get_team_tree_usecase.dart';

class TeamTreeProvider extends ChangeNotifier {
  final GetTeamTreeUseCase getTeamTreeUseCase;

  TeamTreeProvider({required this.getTeamTreeUseCase});

  List<TeamTreeEntity> _teamTree = [];
  List<TeamTreeEntity> _filteredTeamTree = [];
  bool _isLoading = false;
  String? _error;

  // Return filtered data by default
  List<TeamTreeEntity> get teamTree => _filteredTeamTree;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Optional: Get all data including unassigned
  List<TeamTreeEntity> get allTeamData => _teamTree;

  Future<void> fetchTeamTree(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get all team data from use case
      _teamTree = await getTeamTreeUseCase(webUserId);

      // Filter to show only assigned managers
      _filteredTeamTree = _filterAssignedManagers(_teamTree);

    } catch (e, stackTrace) {
      _error = e.toString();

      // Print clearly to console
      debugPrint("❌ Error in fetchTeamTree($webUserId): $e");
      debugPrint("📌 Stack trace: $stackTrace");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Private method to filter assigned managers
  List<TeamTreeEntity> _filterAssignedManagers(List<TeamTreeEntity> teamData) {
    return teamData.where((team) {
      // Filter conditions:
      // 1. Manager ID should be greater than 0
      // 2. Manager name should not be "Unassigned"
      // 3. Should have employees
      return team.managerId > 0 &&
          team.managerName.toLowerCase() != 'unassigned' &&
          team.employees.isNotEmpty;
    }).toList();
  }

  // Optional: Method to toggle between filtered and all data
  void showAllTeams(bool showAll) {
    if (showAll) {
      _filteredTeamTree = _teamTree;
    } else {
      _filteredTeamTree = _filterAssignedManagers(_teamTree);
    }
    notifyListeners();
  }

  // Optional: Get count of filtered vs total teams
  int get assignedManagersCount => _filteredTeamTree.length;
  int get totalManagersCount => _teamTree.length;
}