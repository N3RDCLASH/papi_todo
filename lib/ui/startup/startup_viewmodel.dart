import 'package:sqflite_migration_example/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../services/database_service.dart';

import '../router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _databaseService = locator<DatabaseService>();

  Future initialise() async {
    _databaseService.initialise();
    Future.delayed(Duration.zero, () async {
      await _navigationService.navigateTo(Router.todo);
    });
  }
}
