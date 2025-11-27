import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/home/domain/entities/event_entity.dart';
import 'package:fuoday/features/home/domain/usecases/get_announcement_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_celebrations_usecase.dart';
import 'package:fuoday/features/home/domain/usecases/get_organizational_program_usecase.dart';

class AllEventsProvider extends ChangeNotifier {
  final GetAnnouncementUseCase getAnnouncementUseCase;
  final GetCelebrationsUseCase getCelebrationsUseCase;
  final GetOrganizationalProgramUseCase getOrganizationalProgramUseCase;

  AllEventsProvider({
    required this.getAnnouncementUseCase,
    required this.getCelebrationsUseCase,
    required this.getOrganizationalProgramUseCase,
  });

  List<EventEntity> announcements = [];
  List<EventEntity> celebrations = [];
  List<EventEntity> organizationalPrograms = [];

  bool isLoading = false;
  String? error;

  /// Internal fetch guard
  bool _hasFetched = false;

  Future<void> fetchAllEvents({bool forceRefresh = false}) async {
    if (_hasFetched && !forceRefresh) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final a = await getAnnouncementUseCase();
      final c = await getCelebrationsUseCase();
      final o = await getOrganizationalProgramUseCase();

      announcements = a;
      celebrations = c;
      organizationalPrograms = o;

      _hasFetched = true;
      AppLoggerHelper.logInfo('Fetched all event categories successfully');
    } catch (e) {
      error = e.toString();
      AppLoggerHelper.logError('Failed to load events: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
