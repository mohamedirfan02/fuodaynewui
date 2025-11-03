// import 'package:flutter/material.dart';
// import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';
// import 'package:fuoday/features/manager/domain/usecase/get_all_regulations_usecase.dart';
//
// class AllRegulationsProvider extends ChangeNotifier {
//   final GetAllRegulationsUseCase getAllRegulationsUseCase;
//
//   AllRegulationsProvider({required this.getAllRegulationsUseCase});
//
//   bool isLoading = false;
//   String? errorMessage;
//   AllRegulationsEntity? regulations;
//   String totalCountData = '';
//
//   /// Split Data
//   List<RegulationDataEntity> _allManagerData = [];
//   List<RegulationDataEntity> leaveData = [];
//   List<RegulationDataEntity> attendanceData = [];
//
//   // ✅ Fetch All Regulations
//   Future<void> fetchAllRegulations(int webUserId) async {
//     isLoading = true;
//     errorMessage = null;
//
//     notifyListeners();
//
//     try {
//       final result = await getAllRegulationsUseCase(webUserId);
//       regulations = result;
//
//       // ✅ Extract manager section data
//       _allManagerData = result.managerSection?.data ?? [];
//       totalCountData = (result.managerSection?.totalCount ?? 0).toString();
//       // ✅ Split by Type
//       leaveData = _allManagerData
//           .where((e) => (e.type?.toLowerCase() ?? '') == 'leave')
//           .toList();
//
//       attendanceData = _allManagerData
//           .where((e) => (e.type?.toLowerCase() ?? '') == 'attendance')
//           .toList();
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   /// Get data filtered by type and status
//   List<RegulationDataEntity> getFilteredData({
//     required String selectedType,
//     required String selectedStatus,
//   }) {
//     final typeData = selectedType.toLowerCase() == 'leave'
//         ? leaveData
//         : attendanceData;
//
//     return typeData
//         .where(
//           (e) =>
//               (e.regulationStatus ?? '').toLowerCase() ==
//               selectedStatus.toLowerCase(),
//         )
//         .toList();
//   }
//
//   void clearData() {
//     regulations = null;
//     _allManagerData.clear();
//     leaveData.clear();
//     attendanceData.clear();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';
import 'package:fuoday/features/manager/domain/usecase/get_all_regulations_usecase.dart';

class AllRegulationsProvider extends ChangeNotifier {
  final GetAllRegulationsUseCase getAllRegulationsUseCase;

  AllRegulationsProvider({required this.getAllRegulationsUseCase});

  bool isLoading = false;
  String? errorMessage;
  AllRegulationsEntity? regulations;

  /// Total Counts
  String managerTotalCount = '';
  String hrTotalCount = '';
  String teamTotalCount = '';

  /// Data lists
  List<RegulationDataEntity> managerData = [];
  List<RegulationDataEntity> hrData = [];
  List<RegulationDataEntity> teamData = [];

  /// Split by Type
  List<RegulationDataEntity> managerLeaveData = [];
  List<RegulationDataEntity> managerAttendanceData = [];

  List<RegulationDataEntity> hrLeaveData = [];
  List<RegulationDataEntity> hrAttendanceData = [];

  List<RegulationDataEntity> teamLeaveData = [];
  List<RegulationDataEntity> teamAttendanceData = [];

  // ✅ Fetch All Regulations (Manager, HR, Team)
  Future<void> fetchAllRegulations(int webUserId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await getAllRegulationsUseCase(webUserId);
      regulations = result;

      // ✅ Manager Section
      managerData = result.managerSection?.data ?? [];
      managerTotalCount = (result.managerSection?.totalCount ?? 0).toString();

      managerLeaveData = managerData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'leave')
          .toList();
      managerAttendanceData = managerData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'attendance')
          .toList();

      // ✅ HR Section
      hrData = result.hrSection?.data ?? [];
      hrTotalCount = (result.hrSection?.totalCount ?? 0).toString();

      hrLeaveData = hrData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'leave')
          .toList();
      hrAttendanceData = hrData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'attendance')
          .toList();

      // ✅ Team Section
      teamData = result.teamSection?.data ?? [];
      teamTotalCount = (result.teamSection?.totalCount ?? 0).toString();

      teamLeaveData = teamData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'leave')
          .toList();
      teamAttendanceData = teamData
          .where((e) => (e.type?.toLowerCase() ?? '') == 'attendance')
          .toList();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Get filtered data by section, type, status, and search (by name or emp id)
  List<RegulationDataEntity> getFilteredData({
    required String section, // manager / hr / team
    required String selectedType, // leave / attendance
    required String selectedStatus, // pending / approved / rejected
    String searchQuery = '', // optional
  }) {
    List<RegulationDataEntity> sourceData = [];

    switch (section.toLowerCase()) {
      case 'manager':
        sourceData = selectedType.toLowerCase() == 'leave'
            ? managerLeaveData
            : managerAttendanceData;
        break;
      case 'hr':
        sourceData = selectedType.toLowerCase() == 'leave'
            ? hrLeaveData
            : hrAttendanceData;
        break;
      case 'team':
        sourceData = selectedType.toLowerCase() == 'leave'
            ? teamLeaveData
            : teamAttendanceData;
        break;
    }

    // ✅ Filter by status and search (Employee Name / Employee ID)
    return sourceData.where((e) {
      final matchesStatus =
          (e.regulationStatus ?? '').toLowerCase() ==
          selectedStatus.toLowerCase();

      final matchesSearch =
          searchQuery.isEmpty ||
          (e.empName?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false) ||
          (e.empId?.toString().toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ??
              false);

      return matchesStatus && matchesSearch;
    }).toList();
  }

  void clearData() {
    regulations = null;

    managerData.clear();
    hrData.clear();
    teamData.clear();

    managerLeaveData.clear();
    managerAttendanceData.clear();

    hrLeaveData.clear();
    hrAttendanceData.clear();

    teamLeaveData.clear();
    teamAttendanceData.clear();

    notifyListeners();
  }
}
