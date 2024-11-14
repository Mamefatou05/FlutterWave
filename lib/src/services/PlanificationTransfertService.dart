import '../models/PlanificationTransfertModel.dart';
import '../repositories/ApiRepository.dart';

class PlanificationTransfertService {
  final ApiRepository _apiRepository;

  PlanificationTransfertService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;

  Future<Map<String, dynamic>?> createPlanification(PlanificationTransfertModel planificationDTO) async {
    final response = await _apiRepository.post('/planification', planificationDTO.toJson());

    print("la planification effectuée");
    print("Message : ${response.message}");

    // Vérifiez que `data` est bien un `Map` avant de le retourner
    if (response.data is Map<String, dynamic> && response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      // Log l'erreur si `data` contient un message d'erreur
      print("Erreur lors de la création de la planification: ${response.message}");
      return null;
    }
  }

  Future<void> relancerPlanification(int id) async {
    await _apiRepository.post('/planification/relancer/$id', {});
  }

  Future<void> annulerPlanification(int id) async {
    await _apiRepository.post('/planification/annuler/$id', {});
  }

  Future<void> desactiverPlanification(int id) async {
    await _apiRepository.post('/planification/desactiver/$id', {});
  }
}
