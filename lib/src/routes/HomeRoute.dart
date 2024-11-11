import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/UserProvider.dart';
import '../screens/HomeScreen.dart';
import '../services/UserService.dart';

class HomeRoute {
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) {
        return ChangeNotifierProvider(
          create: (_) => UserProvider(sl<UserService>()),
          child: const HomeScreen(),
        );
      },
    };
  }
}
