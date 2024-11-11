import 'BaseModel.dart';
import 'UserModel.dart';

class Marchand extends BaseModel {
  final String nomCommercial;
  final String adresse;
  final bool estActif;
  final UserModel utilisateur;

  Marchand({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    required this.nomCommercial,
    required this.adresse,
    required this.estActif,
    required this.utilisateur,
  });

  factory Marchand.fromJson(Map<String, dynamic> json) {
    return Marchand(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      nomCommercial: json['nomCommercial'],
      adresse: json['adresse'],
      estActif: json['estActif'],
      utilisateur: UserModel.fromJson(json['utilisateur']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'nomCommercial': nomCommercial,
      'adresse': adresse,
      'estActif': estActif,
      'utilisateur': utilisateur.toJson(),
    };
  }
}
