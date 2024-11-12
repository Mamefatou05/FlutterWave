import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/PlanificationTransfertModel.dart';
import '../services/PlanificationTransfertService.dart';
import 'UserProvider.dart';

class PlanificationTransfertProvider extends ChangeNotifier {
  final PlanificationTransfertService _planificationTransfertService;
  final List<PlanificationTransfert> _planifications = [];
  final UserProvider _userProvider;

  bool _loading = false;
  String? _error;

  // Injection du service dans le constructeur
  PlanificationTransfertProvider(PlanificationTransfertService planificationTransfertService, UserProvider userProvider)
      : _planificationTransfertService = planificationTransfertService,
        _userProvider = userProvider;

  List<PlanificationTransfert> get planifications => _planifications;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> creerPlanification({required PlanificationTransfert planification}) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      // Créer un DTO pour envoyer l'objet via le service
      final planificationDTO = PlanificationTransfertModel(
        expediteurTelephone: _userProvider.user?.numeroTelephone ?? '',
        destinataireTelephone: planification.destinataireTelephone,
        montant: planification.montant,
        periodicite: planification.periodicite,
        heureExecution: planification.heureExecution,
        referenceGroupe: 'Planification1230',
      );

      // Appel au service pour créer la planification
      final response = await _planificationTransfertService.createPlanification(planificationDTO);

      if (response != null) {
        _planifications.add(PlanificationTransfert.fromJson(response));
        notifyListeners();
      } else {
        _error = "Erreur lors de la création de la planification.";
      }
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur lors de la création de la planification: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> chargerPlanifications() async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _planifications.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur lors du chargement des planifications: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> annulerPlanification(int id) async {
    try {
      await _planificationTransfertService.annulerPlanification(id);
      _planifications.removeWhere((plan) => plan.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur lors de l\'annulation de la planification: $e');
    }
  }

  Future<void> relancerPlanification(int id) async {
    try {
      await _planificationTransfertService.relancerPlanification(id);
      await chargerPlanifications(); // Recharger la liste après relance
    } catch (e) {
      _error = e.toString();
      debugPrint('Erreur lors de la relance de la planification: $e');
    }
  }
}
