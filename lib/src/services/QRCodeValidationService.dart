import '../repositories/ApiRepository.dart';

class QRCodeValidationService {
  final ApiRepository _apiRepository;

  QRCodeValidationService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;

  Future<Map<String, dynamic>> validateQRCode(String qrCodeBase64) async {
    try {
      final response = await _apiRepository.post('/qrcode/validate', {'qrCode': qrCodeBase64});
      return response.data;
    } catch (e) {
      throw Exception('Erreur lors de la validation du QR code: ${e.toString()}');
    }
  }
}

