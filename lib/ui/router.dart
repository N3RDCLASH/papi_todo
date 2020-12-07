import 'package:flutter/material.dart';
import 'package:papi_todo/ui/single_todo/single_todo_view.dart';
import 'package:papi_todo/ui/todo/todo_view.dart';

/// Function created using the router setup found in the below FilledStacks article.
/// https://www.filledstacks.com/post/flutter-navigation-cheatsheet-a-guide-to-named-routing/#setup-a-router-for-named-routing

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case single:
      // return MaterialPageRoute(builder: (context) => SingleTodoView());
      case todo:
      default:
        return MaterialPageRoute(builder: (context) => TodoView());
    }
  }

  static const todo = 'todo';
  static const single = 'single';
}
