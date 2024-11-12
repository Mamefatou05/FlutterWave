import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/di/ServiceLocator.dart';
import '../providers/TransactionProvider.dart';
import '../providers/UserProvider.dart';
import '../screens/MultipleTransferScreen.dart';
import '../screens/TransactionScreen.dart';
import '../services/TransactionService.dart';

class TransactionRoute {
  static const String single = '/transfert';
  static const String multiple = '/transfert-multiple';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      single: (context) => ChangeNotifierProvider(
        create: (_) => TransactionProvider(
          sl<TransactionService>(),
          sl<UserProvider>(),
        ),
        child: const TransactionScreen(),
      ),
      multiple: (context) => ChangeNotifierProvider(
        create: (_) => TransactionProvider(
          sl<TransactionService>(),
          sl<UserProvider>(),
        ),
        child:  MultipleTransferScreen(),
      ),
    };
  }
}
