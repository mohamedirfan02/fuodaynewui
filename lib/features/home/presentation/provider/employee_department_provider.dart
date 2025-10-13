import 'package:flutter/material.dart';

import '../../domain/entities/emp_department_entity.dart';
import '../../domain/usecases/emp_department_usecase.dart';

class EmployeeDepartmentProvider with ChangeNotifier {
  final GetEmployeesByManagerUseCase getEmployeesByManagerUseCase;

  EmployeeDepartmentProvider({required this.getEmployeesByManagerUseCase});

  bool _isLoading = false;
  String? _errorMessage;
  EmployeeDepartmentEntity? _employeeDepartment;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  EmployeeDepartmentEntity? get employeeDepartment => _employeeDepartment;

  Future<void> fetchEmployees(int webUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getEmployeesByManagerUseCase.call(webUserId);
      _employeeDepartment = result;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
