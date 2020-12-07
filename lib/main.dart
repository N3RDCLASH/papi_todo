import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papi_todo/app/locator.dart';
import 'package:papi_todo/ui/router.dart' as router;
import 'package:papi_todo/ui/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartupView(),
      onGenerateRoute: router.Router.onGenerateRoute,
      theme: ThemeData(primaryColor: Colors.green[900]),
    );
  }
}
