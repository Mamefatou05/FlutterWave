import 'package:SenCash/src/core/di/ServiceLocator.dart';
import 'package:SenCash/src/providers/UserProvider.dart';
import 'package:SenCash/src/theme/AppColors.dart';
import 'package:SenCash/src/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/providers/AuthProvider.dart';
import 'src/repositories/ApiRepository.dart';
import 'src/routes/routes.dart'; // Assurez-vous d'importer le fichier central des routes
import 'src/services/AuthService.dart';
import 'src/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator(); // Configure tous les services avant de démarrer l'app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // AuthProvider pour la gestion de l'authentification
        ChangeNotifierProvider(
          create: (_) => AuthProvider(sl<AuthService>()),
        ),

        // UserProvider pour la gestion des utilisateurs
        ChangeNotifierProvider(
          create: (_) => UserProvider(sl<UserService>()),
        ),
      ],
      child: MaterialApp(
        title: 'SenCash App',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
        ),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
