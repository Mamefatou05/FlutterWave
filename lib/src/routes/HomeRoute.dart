import 'package:flutter/material.dart';
import '../screens/HomeScreen.dart';

class HomeRoute {
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => QRPayHome(),
    };
  }
}
