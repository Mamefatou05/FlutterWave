import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/di/ServiceLocator.dart';
import '../providers/QRProvider.dart';
import '../screens/QRScreen.dart';
import '../services/QRCodeValidationService.dart';

class QRRoute {
  static const String qr = '/qr';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      qr: (context) {
        return MultiProvider(
          providers: [
            Provider<QRCodeValidationService>.value(value: sl<QRCodeValidationService>()),
            ChangeNotifierProvider(
              create: (_) => QRProvider(sl<QRCodeValidationService>()),
            ),
          ],
          child: const QRScreen(),
        );
      },
    };
  }
}
