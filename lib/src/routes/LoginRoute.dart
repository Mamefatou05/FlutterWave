import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../screens/LoginScreen.dart';
import '../providers/AuthProvider.dart';
import '../services/AuthService.dart';
import '../repositories/ApiRepository.dart';

class LoginRoute {
  static const String login = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) {
        // Use the instance of AuthService from the service locator
        final authService = sl<AuthService>();

        return MultiProvider(
          providers: [
            Provider<AuthService>.value(value: authService),
            ChangeNotifierProvider(
              create: (_) => AuthProvider(authService ),
            ),
          ],
          child: LoginScreen(),
        );
      },
    };
  }
}
