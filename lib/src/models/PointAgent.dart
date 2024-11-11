import 'package:decimal/decimal.dart';

import 'BaseModel.dart';
import 'UserModel.dart';

class PointAgent extends BaseModel {
  final UserModel agent;
  final String adresse;
  final bool estActif;
  final Decimal soldeFlottant;

  PointAgent({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    required this.agent,
    required this.adresse,
    required this.estActif,
    required this.soldeFlottant,
  });

  factory PointAgent.fromJson(Map<String, dynamic> json) {
    return PointAgent(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      agent: UserModel.fromJson(json['agent']),
      adresse: json['adresse'],
      estActif: json['estActif'],
      soldeFlottant: Decimal.parse(json['soldeFlottant'].toString()),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'agent': agent.toJson(),
      'adresse': adresse,
      'estActif': estActif,
      'soldeFlottant': soldeFlottant.toString(),
    };
  }
}

