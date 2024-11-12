import 'dart:convert';

class PlanificationTransfertModel {
  final String expediteurTelephone;
  final String destinataireTelephone;
  final double montant;  // Vous pouvez aussi utiliser Decimal si nécessaire
  final String periodicite;
  final String? referenceGroupe;
  final String heureExecution;

  PlanificationTransfertModel({
    required this.expediteurTelephone,
    required this.destinataireTelephone,
    required this.montant,
    required this.periodicite,
    this.referenceGroupe,
    required this.heureExecution,
  });

  // Méthode toJson pour convertir l'objet en Map
  Map<String, dynamic> toJson() {
    return {
      'expediteurTelephone': expediteurTelephone,
      'destinataireTelephone': destinataireTelephone,
      'montant': montant,
      'periodicite': periodicite,
      'referenceGroupe': referenceGroupe,
      'heureExecution': heureExecution,
    };
  }

  // Méthode fromJson pour créer l'objet à partir d'un Map
  factory PlanificationTransfertModel.fromJson(Map<String, dynamic> json) {
    return PlanificationTransfertModel(
      expediteurTelephone: json['expediteurTelephone'],
      destinataireTelephone: json['destinataireTelephone'],
      montant: json['montant'].toDouble(),  // Assurez-vous que c'est un double
      periodicite: json['periodicite'],
      referenceGroupe: json['referenceGroupe'],
      heureExecution: json['heureExecution'],
    );
  }

  @override
  String toString() {
    return 'PlanificationTransfertModel{expediteurTelephone: $expediteurTelephone, destinataireTelephone: $destinataireTelephone, montant: $montant, periodicite: $periodicite, referenceGroupe: $referenceGroupe, heureExecution: $heureExecution}';
  }
}


class PlanificationTransfert {
  final String id;
  final String destinataireTelephone;
  final double montant;
  final String periodicite;
  final String heureExecution; // Format "HH:mm" pour une représentation simple de l'heure

  PlanificationTransfert({
    required this.id,
    required this.destinataireTelephone,
    required this.montant,
    required this.periodicite,
    required this.heureExecution,
  });

  // Méthode pour créer une instance depuis une map (utile pour la récupération de données JSON ou Firebase)
  factory PlanificationTransfert.fromMap(Map<String, dynamic> data) {
    return PlanificationTransfert(
      id: data['id'] ?? '',
      destinataireTelephone: data['destinataireTelephone'] ?? '',
      montant: data['montant']?.toDouble() ?? 0.0,
      periodicite: data['periodicite'] ?? 'JOURNALIER',
      heureExecution: data['heureExecution'] ?? '00:00',
    );
  }

  factory PlanificationTransfert.fromJson(Map<String, dynamic> json) {
    return PlanificationTransfert(
      id: json['id'] ?? '',
      destinataireTelephone: json['destinataireTelephone'] ?? '',
      montant: (json['montant'] ?? 0.0).toDouble(),
      periodicite: json['periodicite'] ?? 'JOURNALIER',
      heureExecution: json['heureExecution'] ?? '00:00',
    );
  }

  // Méthode pour convertir une instance en map (utile pour envoyer des données JSON ou Firebase)
  Map<String, dynamic> toMap() {
    return {
      'destinataireTelephone': destinataireTelephone,
      'montant': montant,
      'periodicite': periodicite,
      'heureExecution': heureExecution,
    };
  }

  // Méthode d'affichage pour faciliter le debug
  @override
  String toString() {
    return 'PlanificationTransfert(id: $id, destinataireTelephone: $destinataireTelephone, montant: $montant, periodicite: $periodicite, heureExecution: $heureExecution)';
  }
}

