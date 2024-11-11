import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/TransactionProvider.dart';
import '../providers/UserProvider.dart';
import '../screens/HistoryScreen.dart';
import '../services/TransactionService.dart';

class HistoryRoute {
  static const String history = '/history';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      history: (context) {
        return ChangeNotifierProvider(
          create: (_) => TransactionProvider(sl<TransactionService>(),sl<UserProvider>()),
          child: const HistoryScreen(),
        );
      },
    };
  }
}