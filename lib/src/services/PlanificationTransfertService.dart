import '../models/PlanificationTransfertModel.dart';
import '../repositories/ApiRepository.dart';

class PlanificationTransfertService {
  final ApiRepository _apiRepository;

  PlanificationTransfertService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;

  Future<Map<String, dynamic>?> createPlanification(PlanificationTransfertModel planificationDTO) async {
    final response = await _apiRepository.post('/planification', planificationDTO.toJson());
    return response.data;
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
