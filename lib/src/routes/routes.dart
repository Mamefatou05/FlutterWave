import 'package:SenCash/src/routes/PlanificationRoute.dart';
import 'package:SenCash/src/routes/QRRoute.dart';
import 'package:SenCash/src/routes/TransactionRoute.dart';
import 'package:flutter/material.dart';
import 'HistoryRoute.dart';
import 'LoginRoute.dart';
import 'HomeRoute.dart';
import 'RegisterRoute.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      ...LoginRoute.getRoutes(),
      ...HomeRoute.getRoutes(),
      ...RegisterRoute.getRoutes(),
      ...HistoryRoute.getRoutes(),
      ...QRRoute.getRoutes(),
      ...TransactionRoute.getRoutes(),
      ...PlanificationRoute.getRoutes(),
    };
  }

  // Assurez-vous que la route initiale pointe vers la route home
  static const String initialRoute = LoginRoute.login;
}
