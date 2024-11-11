import 'package:flutter/foundation.dart';

import '../models/UserModel.dart';
import '../services/QRCodeValidationService.dart';


class QRProvider with ChangeNotifier {


  final QRCodeValidationService _qrCodeValidationService;

  QRProvider(this._qrCodeValidationService);

  // Call your backend API or service to validate the QR code
  Future<UserModel?> validateQR(String qrData) async {
    try {
      // Appelez le service pour valider le QR code
      final response = await _qrCodeValidationService.validateQRCode(qrData);

      if (response != null) {
        // Si la réponse est valide, créez l'utilisateur à partir des données renvoyées
        return UserModel.fromJson(response);
      }
      return null;
    } catch (e) {
      // Gérer l'erreur si nécessaire, par exemple, en affichant un message d'erreur
      print("Erreur lors de la validation du QR code: $e");
      return null;
    }
  }
}
