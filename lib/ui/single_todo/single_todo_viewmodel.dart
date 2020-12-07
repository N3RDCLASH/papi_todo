import 'package:flutter/scheduler.dart';
import 'package:papi_todo/app/locator.dart';
import 'package:papi_todo/models/todo.dart';
import 'package:papi_todo/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

import '../router.dart';

class SingleTodoViewModel extends FutureViewModel<List<Todo>> {
  final _databaseService = locator<DatabaseService>();
  final _navigationService = locator<NavigationService>();

  @override
  Future<List<Todo>> futureToRun() => _databaseService.getOpenTodos();

  void navigateToSingle() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _navigationService.navigateTo(Router.single);
    });
  }
  // Future setCompleteForItem(int index, bool value) async {
  //   await _databaseService.updateCompleteForTodo(
  //       id: data[index].id, complete: value);

  //   // Initialise will rerun the initial FutureViewModel logic which will
  //   // 1. Run the Future provided to futureToRun()
  //   // 2. Store the value returned from that future in the data property
  //   await initialise();
  // }

  // Future updateTodo(int index, String title, String description) async {
  //   await _databaseService.updateTodo(
  //       id: data[index].id, title: title, description: description);

  //   // Initialise will rerun the initial FutureViewModel logic which will
  //   // 1. Run the Future provided to futureToRun()
  //   // 2. Store the value returned from that future in the data property
  //   await initialise();
  // }
}
