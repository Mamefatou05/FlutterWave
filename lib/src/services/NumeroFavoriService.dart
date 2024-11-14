

import '../models/NumeroFavori.dart';
import '../repositories/ApiRepository.dart';

class NumeroFavoriService {
  final ApiRepository _apiRepository;

  NumeroFavoriService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;


  Future<List<NumeroFavori>> getAllNumerosFavoris(int clientId) async {
    final response = await _apiRepository.get('/api/favoris/$clientId');
    if (response.statusCode == 200) {
      return (response.data as List).map((item) => NumeroFavori.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch favorite numbers');
    }
  }

  Future<NumeroFavori> ajouterNumeroFavori(
      int clientId,
      String numeroTelephone, [
        String? nom,
      ]) async {
    final response = await _apiRepository.post(
      '/api/favoris/$clientId',
      {'numeroTelephone': numeroTelephone, 'nom': nom},
    );
    if (response.statusCode == 200) {
      return NumeroFavori.fromJson(response.data);
    } else {
      throw Exception('Failed to add favorite number');
    }
  }

  Future<void> supprimerNumeroFavori(int clientId, String numeroTelephone) async {
    final response = await _apiRepository.delete('/api/favoris/$clientId?numeroTelephone=$numeroTelephone');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete favorite number');
    }
  }
}