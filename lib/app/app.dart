import 'package:flutter/material.dart';
import 'package:zimster_messaging/managers/dialog_manager.dart';

import '../services/dialog_service.dart';
import '../services/navigation_service.dart';

import '../app/route_paths.dart' as routes;
import '../services/router.dart' as router;
import '../app/constants.dart' as constants;

import '../app/service_locator.dart';

class App extends StatelessWidget {
  ThemeData _buildTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: constants.appPrimaryColor,
      primaryColorLight: constants.appPrimaryLightColor,
      buttonColor: Theme.of(context).primaryColor,
      accentColor: constants.appAccentColor,
      backgroundColor: constants.appScaffoldBackgroundColor,
      appBarTheme: AppBarTheme().copyWith(

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zimster ',
      theme: _buildTheme(context),
      //builder below is need to ensure dialoge service stays at the top of widget tree
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
      //TODO FIX THIS
      onGenerateRoute: router.generateRoute,
      navigatorKey: serviceLocator<NavigationService>().navigationKey,
      initialRoute: routes.StartupRoute,
    );
  }
}
