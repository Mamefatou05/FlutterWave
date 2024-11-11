import 'package:flutter/cupertino.dart';

class Role {
  final int id;
  final String? dateCreation;  // Rendu nullable
  final String? dateModification;  // Rendu nullable
  final String nom;

  Role({
    required this.id,
    this.dateCreation,
    this.dateModification,
    required this.nom,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    try {
      return Role(
        id: json['id'] as int,
        dateCreation: json['dateCreation']?.toString(),  // Utilisation de ?. pour gérer null
        dateModification: json['dateModification']?.toString(),  // Utilisation de ?. pour gérer null
        nom: json['nom']?.toString() ?? '',  // Valeur par défaut si null
      );
    } catch (e, stackTrace) {
      debugPrint('Error parsing Role: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('Role JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateCreation': dateCreation,
      'dateModification': dateModification,
      'nom': nom,
    };
  }

  @override
  String toString() {
    return 'Role(id: $id, nom: $nom)';
  }
}