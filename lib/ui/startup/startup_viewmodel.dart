import 'package:flutter/scheduler.dart';
import 'package:papi_todo/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../services/database_service.dart';

import '../router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  Future initialise() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _databaseService.initialise();
      await _navigationService.navigateTo(Router.todo);
    });
    // });
  }
}
