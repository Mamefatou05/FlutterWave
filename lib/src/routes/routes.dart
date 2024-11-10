import 'package:flutter/material.dart';
import 'LoginRoute.dart';
import 'HomeRoute.dart';
import 'RegisterRoute.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ...LoginRoute.getRoutes(),
      ...HomeRoute.getRoutes(),
      ...RegisterRoute.getRoutes(),
    };
  }

  // Assurez-vous que la route initiale pointe vers la route home
  static const String initialRoute = LoginRoute.login;
}
