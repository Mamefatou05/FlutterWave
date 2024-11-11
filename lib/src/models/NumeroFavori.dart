import 'BaseModel.dart';
import 'UserModel.dart';

class NumeroFavori extends BaseModel {
  final UserModel client;
  final String numeroTelephone;
  final String? nom;
  final DateTime dateAjout;

  NumeroFavori({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    required this.client,
    required this.numeroTelephone,
    this.nom,
    required this.dateAjout,
  });

  factory NumeroFavori.fromJson(Map<String, dynamic> json) {
    return NumeroFavori(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      client: UserModel.fromJson(json['client']),
      numeroTelephone: json['numeroTelephone'],
      nom: json['nom'],
      dateAjout: DateTime.parse(json['dateAjout']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'client': client.toJson(),
      'numeroTelephone': numeroTelephone,
      'nom': nom,
      'dateAjout': dateAjout.toIso8601String(),
    };
  }
}