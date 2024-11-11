
import '../repositories/ApiRepository.dart';

class QRCodeValidationService {
  final ApiRepository _apiRepository;

  QRCodeValidationService({
    required ApiRepository apiRepository,
  })  : _apiRepository = apiRepository;
  Future<Map<String, dynamic>> validateQRCode(String qrCodeBase64) async {
    try {
      // Appel à l'API via l'ApiRepository
      final response = await _apiRepository.post('/qrcode/validate', {'qrCode': qrCodeBase64});

      if (response['status'] == 'SUCCESS') {
        return response['data']; // Retourne les données de l'utilisateur
      } else {
        throw Exception('Validation QR échouée');
      }
    } catch (e) {
      throw Exception('Erreur lors de la validation du QR code: ${e.toString()}');
    }
  }
}
