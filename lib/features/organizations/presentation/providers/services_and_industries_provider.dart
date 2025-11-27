import 'package:flutter/material.dart';
import 'package:fuoday/features/organizations/domain/entities/ser_ind_entities.dart';
import 'package:fuoday/features/organizations/domain/usecase/ser_ind_usecase.dart';

class ServicesAndIndustriesProvider with ChangeNotifier {
  final GetServicesAndIndustriesUseCase getServicesAndIndustriesUseCase;

  ServicesAndIndustriesProvider({required this.getServicesAndIndustriesUseCase});

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  ServicesAndIndustriesEntity? model;

  Future<void> getServicesAndIndustries(String webUserId) async {
    isLoading = true;
    hasError = false;
    errorMessage = '';
    notifyListeners();

    try {
      final data = await getServicesAndIndustriesUseCase.call(webUserId);
      model = data;
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
