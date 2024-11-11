import 'package:decimal/decimal.dart';

import 'BaseModel.dart';
import 'UserModel.dart';

class Plafond extends BaseModel {
  final UserModel utilisateur;
  final Decimal limiteJournaliere;
  final Decimal limiteMensuelle;
  final Decimal montantMaxTransaction;

  Plafond({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    required this.utilisateur,
    required this.limiteJournaliere,
    required this.limiteMensuelle,
    required this.montantMaxTransaction,
  });

  factory Plafond.fromJson(Map<String, dynamic> json) {
    return Plafond(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      utilisateur: UserModel.fromJson(json['utilisateur']),
      limiteJournaliere: Decimal.parse(json['limiteJournaliere'].toString()),
      limiteMensuelle: Decimal.parse(json['limiteMensuelle'].toString()),
      montantMaxTransaction: Decimal.parse(json['montantMaxTransaction'].toString()),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'utilisateur': utilisateur.toJson(),
      'limiteJournaliere': limiteJournaliere.toString(),
      'limiteMensuelle': limiteMensuelle.toString(),
      'montantMaxTransaction': montantMaxTransaction.toString(),
    };
  }
}