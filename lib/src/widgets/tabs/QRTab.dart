import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../providers/QRProvider.dart';
import '../../providers/UserProvider.dart';
import '../../screens/TransactionScreen.dart';

class QRTab extends StatelessWidget {
  const QRTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
    );
  }
}

class MyQRView extends StatefulWidget {
  @override
  State<MyQRView> createState() => _MyQRViewState();
}

class _MyQRViewState extends State<MyQRView> {


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Si l'utilisateur a un QR code
        if (user.codeQr != null && user.codeQr!.isNotEmpty) {
          // Supprimez le préfixe "data:image/png;base64," s'il est présent
          String base64String = user.codeQr!;
          if (base64String.startsWith('data:image/png;base64,')) {
            base64String = base64String.substring('data:image/png;base64,'.length);
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Affichage du QR code depuis la chaîne base64 sans le préfixe
                Image.memory(
                  base64Decode(base64String),
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 16),
                const Text('Montrez ce QR code pour recevoir un paiement'),
              ],
            ),
          );
        }

        return const Center(child: Text('Aucun QR code disponible pour cet utilisateur.'));
      },
    );
  }

}
class QRScannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MobileScanner(
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                _handleQRCode(context, barcode.rawValue ?? '');
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Placez le QR code dans le cadre pour scanner'),
        ),
      ],
    );
  }

  void _handleQRCode(BuildContext context, String data) async {
    final qrProvider = context.read<QRProvider>();

    // Afficher un indicateur de chargement pendant la validation
    showDialog(
      context: context,
      barrierDismissible: false, // L'utilisateur ne peut pas fermer le dialog en dehors
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Valider les données du QR code
      final user = await qrProvider.validateQR(data); // Retourne l'utilisateur

      if (user != null) {
        // Si la validation réussit, on navigue vers l'écran de transaction avec l'utilisateur
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionScreen(receiverData: user), // Passer l'utilisateur
          ),
        );
      } else {
        // Si la validation échoue ou les données sont invalides
        Navigator.pop(context); // Fermer l'indicateur de chargement
        _showErrorDialog(context, 'QR code invalide ou données incorrectes.');
      }
    } catch (e) {
      // En cas d'exception, fermer l'indicateur de chargement et afficher un message d'erreur
      Navigator.pop(context);
      _showErrorDialog(context, 'Une erreur est survenue lors de la validation.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme le dialogue
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
