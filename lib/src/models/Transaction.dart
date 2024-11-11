import 'package:decimal/decimal.dart';

import 'BaseModel.dart';
import 'TrasactionModel.dart';
import 'UserModel.dart';

class Transaction extends BaseModel {
  final UserModel? expediteur;
  final UserModel? destinataire;
  final Decimal montant;
  final TransactionType typeTransaction;
  final TransactionStatus statut;
  final String? referenceGroupe;
  final Decimal? fraisTransfert;
  final Transaction? transactionOrigine;
  final DateTime? dateAnnulation;
  final String? motifAnnulation;

  Transaction({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    this.expediteur,
    this.destinataire,
    required this.montant,
    required this.typeTransaction,
    required this.statut,
    this.referenceGroupe,
    this.fraisTransfert,
    this.transactionOrigine,
    this.dateAnnulation,
    this.motifAnnulation,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      expediteur: json['expediteur'] != null
          ? UserModel.fromJson(json['expediteur'])
          : null,
      destinataire: json['destinataire'] != null
          ? UserModel.fromJson(json['destinataire'])
          : null,
      montant: Decimal.parse(json['montant'].toString()),
      typeTransaction: TransactionType.values.firstWhere(
              (e) => e.toString() == 'TransactionType.${json['typeTransaction']}'),
      statut: TransactionStatus.values.firstWhere(
              (e) => e.toString() == 'TransactionStatus.${json['statut']}'),
      referenceGroupe: json['referenceGroupe'],
      fraisTransfert: json['fraisTransfert'] != null
          ? Decimal.parse(json['fraisTransfert'].toString())
          : null,
      transactionOrigine: json['transactionOrigine'] != null
          ? Transaction.fromJson(json['transactionOrigine'])
          : null,
      dateAnnulation: json['dateAnnulation'] != null
          ? DateTime.parse(json['dateAnnulation'])
          : null,
      motifAnnulation: json['motifAnnulation'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'expediteur': expediteur?.toJson(),
      'destinataire': destinataire?.toJson(),
      'montant': montant.toString(),
      'typeTransaction': typeTransaction.toString().split('.').last,
      'statut': statut.toString().split('.').last,
      'referenceGroupe': referenceGroupe,
      'fraisTransfert': fraisTransfert?.toString(),
      'transactionOrigine': transactionOrigine?.toJson(),
      'dateAnnulation': dateAnnulation?.toIso8601String(),
      'motifAnnulation': motifAnnulation,
    };
  }
}