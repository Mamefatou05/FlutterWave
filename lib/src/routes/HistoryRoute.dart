import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/TransactionProvider.dart';
import '../providers/UserProvider.dart';
import '../screens/HistoryScreen.dart';
import '../services/TransactionService.dart';
import '../services/UserService.dart';  // N'oubliez pas d'importer UserService

class HistoryRoute {
  static const String history = '/history';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      history: (context) {
        return MultiProvider(
          providers: [
            // Fournisseur pour TransactionProvider
            ChangeNotifierProvider(
              create: (_) => TransactionProvider(
                sl<TransactionService>(),
                sl<UserProvider>(),
              ),
            ),
            // Fournisseur pour UserProvider
            ChangeNotifierProvider(
              create: (_) => UserProvider(sl<UserService>()),
            ),
          ],
          child: const HistoryScreen(),
        );
      },
    };
  }
}
