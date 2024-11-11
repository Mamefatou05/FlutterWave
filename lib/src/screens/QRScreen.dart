import 'package:flutter/material.dart';
import '../routes/QRRoute.dart';
import '../widgets/WaveHeader.dart';
import '../widgets/layout/CustomFooter.dart';
import '../widgets/tabs/QRTab.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WaveHeader(
            title: 'Scanner QR',
            subtitle: 'Scannez un QR code pour payer',
            showBackButton: false,
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Mon QR'),
                      Tab(text: 'Scanner'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        MyQRView(),
                        QRScannerView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomFooter(
        currentRoute: QRRoute.qr,
      ),
    );
  }
}