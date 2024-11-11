import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/di/ServiceLocator.dart';
import '../providers/TransactionProvider.dart';
import '../providers/UserProvider.dart';
import '../screens/TransactionScreen.dart';
import '../services/TransactionService.dart';


class TransactionRoute {
  static const String home = '/transfert';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) {
        return ChangeNotifierProvider(
          create: (_) => TransactionProvider(sl<TransactionService>(), sl<UserProvider>()),
          child: const TransactionScreen(),
        );
      },
    };
  }
}
