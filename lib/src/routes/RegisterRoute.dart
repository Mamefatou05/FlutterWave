import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/UserProvider.dart';
import '../screens/RegisterScreen.dart';
import '../services/UserService.dart';

class RegisterRoute {
  static const String login = '/register';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) {
        // Use the instance of AuthService from the service locator
        final userService = sl<UserService>();

        return MultiProvider(
          providers: [
            Provider<UserService>.value(value: userService),
            ChangeNotifierProvider(
              create: (_) => UserProvider(userService ),
            ),
          ],
          child: RegisterScreen(),
        );
      },
    };
  }
}
