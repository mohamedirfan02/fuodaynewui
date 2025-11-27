import 'package:flutter/cupertino.dart';
import 'package:fuoday/features/management/domain/entities/emp_audit_form_entity.dart';
import 'package:fuoday/features/management/domain/usecase/get_employees_by_managers_usecase.dart';

class EmpAuditFormProvider extends ChangeNotifier {
  final GetEmployeesByManagersUseCase getEmployeesByManagersUseCase;

  EmpAuditFormProvider(this.getEmployeesByManagersUseCase);

  bool _isLoading = false;
  String? _error;
  EmpAuditFormEntity? _empAuditFormData;

  bool get isLoading => _isLoading;
  String? get error => _error;
  EmpAuditFormEntity? get empAuditFormData => _empAuditFormData;

  // Get all employees across all managers as a flat list for table display
  List<EmployeeAuditEntity> get allEmployees {
    if (_empAuditFormData == null) return [];

    final List<EmployeeAuditEntity> employees = [];
    for (final manager in _empAuditFormData!.data) {
      employees.addAll(manager.employees);
    }
    return employees;
  }

  // Get managers with their employees for grouped display
  List<ManagerWithEmployeesEntity> get managersWithEmployees {
    return _empAuditFormData?.data ?? [];
  }

  // Get statistics
  int get totalEmployees => allEmployees.length;
  int get submittedCount => allEmployees.where((emp) => emp.isSubmitted).length;
  int get notSubmittedCount => allEmployees.where((emp) => !emp.isSubmitted).length;

  Future<void> fetchEmployeesByManagers(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _empAuditFormData = await getEmployeesByManagersUseCase.call(webUserId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _empAuditFormData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _empAuditFormData = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}