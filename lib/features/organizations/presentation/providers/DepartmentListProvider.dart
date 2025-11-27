import 'package:flutter/cupertino.dart';
import 'package:fuoday/features/organizations/domain/entities/DepartmentMemberEntity.dart';
import 'package:fuoday/features/organizations/domain/usecase/GetDepartmentListUseCase.dart';

class DepartmentListProvider with ChangeNotifier {
  final GetDepartmentListUseCase getDepartmentListUseCase;

  DepartmentListProvider({required this.getDepartmentListUseCase});

  bool isLoading = false;
  String? error;
  Map<String, List<DepartmentMemberEntity>> data = {};
  Map<String, List<DepartmentMemberEntity>> get departments => data;


  Future<void> fetchDepartmentList(String webUserId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      data = await getDepartmentListUseCase(webUserId);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
