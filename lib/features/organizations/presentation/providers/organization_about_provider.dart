import 'package:flutter/material.dart';
import 'package:fuoday/features/organizations/domain/entities/organization_about_entity.dart';
import 'package:fuoday/features/organizations/domain/usecase/get_about_organization_usecase.dart';

class OrganizationAboutProvider extends ChangeNotifier {
  final GetAboutOrganizationUseCase _getAboutOrganizationUseCase;

  OrganizationAboutProvider(this._getAboutOrganizationUseCase);

  OrganizationAboutEntity? _aboutData;
  bool _isLoading = false;
  String? _error;

  OrganizationAboutEntity? get aboutData => _aboutData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAboutData(String webUserId) async {

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _getAboutOrganizationUseCase.call(webUserId);
      _aboutData = data;
    } catch (e) {
      _error = e.toString();
      _aboutData = null;
    }

    _isLoading = false;
    notifyListeners();
  }

}
