import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/PlanificationTransfertProvider.dart';
import '../providers/UserProvider.dart';
import '../screens/CreerPlanificationScreen.dart';
import '../services/PlanificationTransfertService.dart';
import '../services/UserService.dart';


class PlanificationRoute {
  static const String create = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      create: (context) {
        return MultiProvider(
          providers: [
            // UserProvider pour la gestion des utilisateurs
            ChangeNotifierProvider(
              create: (_) => UserProvider(sl<UserService>()),
            ),
            ChangeNotifierProvider(
              create: (_) => PlanificationTransfertProvider(sl<PlanificationTransfertService>(), sl<UserProvider>()),
            ),

          ],
          child: CreerPlanificationScreen(),
        );
      },

    };
  }
}
