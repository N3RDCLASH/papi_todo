import 'package:flutter/scheduler.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:papi_todo/app/locator.dart';
import 'package:papi_todo/models/todo.dart';
import 'package:papi_todo/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../router.dart';
import 'package:stacked/stacked.dart';

class TodoViewModel extends FutureViewModel<List<Todo>>
    with ReactiveServiceMixin {
  final _databaseService = locator<DatabaseService>();
  final _navigationService = locator<NavigationService>();

  String _title = "To-Do's";
  String get title => '$_title';
  @override
   Future<List<Todo>> futureToRun() => _databaseService.getTodos();

  Future addTodo(String title, String description) async {
    await _databaseService.addTodo(title: title, description: description);

    // Initialise will rerun the initial FutureViewModel logic which will
    // 1. Run the Future provided to futureToRun()
    // 2. Store the value returned from that future in the data property
    // Future.delayed(Zero)
    await initialise();
    notifyListeners();
  }

  Future setCompleteForItem(int index, bool value) async {
    await _databaseService.updateCompleteForTodo(
        id: data[index].id, complete: value);

    // Initialise will rerun the initial FutureViewModel logic which will
    // 1. Run the Future provided to futureToRun()
    // 2. Store the value returned from that future in the data property
    await initialise();
    print('update1:initialised');
  }

  Future updateTodo(int index, String title, String description) async {
    await _databaseService.updateTodo(
        id: data[index].id, title: title, description: description);

    // Initialise will rerun the initial FutureViewModel logic which will
    // 1. Run the Future provided to futureToRun()
    // 2. Store the value returned from that future in the data property
    await initialise();
    print('update3:initialised');
  }

  Future deleteTodo(int index) async {
    await _databaseService.deleteTodo(id: data[index].id);

    // Initialise will rerun the initial FutureViewModel logic which will
    // 1. Run the Future provided to futureToRun()
    // 2. Store the value returned from that future in the data property
    await initialise();
    print('delete:initialised');
  }
}
