import 'package:flutter/material.dart';
import '../routes/HistoryRoute.dart';
import '../routes/routes.dart';
import '../widgets/layout/WaveHeader.dart';
import '../widgets/layout/CustomFooter.dart';
import '../widgets/tabs/HistoryTab.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WaveHeader(
            title: 'Historique',
            subtitle: 'Vos transactions récentes',
            showBackButton: false,
          ),
          const Expanded(
            child: HistoryTab(),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        currentRoute: HistoryRoute.history,
      ),
    );
  }
}