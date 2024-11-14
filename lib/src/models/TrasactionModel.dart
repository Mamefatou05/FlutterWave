import 'dart:convert';

enum Periodicity { DAILY, WEEKLY, MONTHLY }
enum TransactionStatus { PENDING, COMPLETED, CANCELLED, UNKNOWN }
enum TransactionType { TRANSFER, DEPOSIT, WITHDRAWAL, DEFAULT }

class TransferRequestDto {
  final String senderPhoneNumber;
  final String recipientPhoneNumber;
  final double amount;
  final Periodicity? periodicity;
  final String? groupReference;

  TransferRequestDto({
    required this.senderPhoneNumber,
    required this.recipientPhoneNumber,
    required this.amount,
    this.periodicity,
    this.groupReference,
  });

  Map<String, dynamic> toJson() => {
    'senderPhoneNumber': senderPhoneNumber,
    'recipientPhoneNumber': recipientPhoneNumber,
    'amount': amount,
    'periodicity': periodicity?.name,
    'groupReference': groupReference,
  };
}

class TransferResponseDto {
  final int transactionId; // Changement de `id` à `transactionId`
  final String senderFullName; // Correspondance avec `senderFullName` au lieu de `senderPhoneNumber`
  final String receiverFullName; // Correspondance avec `receiverFullName` au lieu de `recipientPhoneNumber`
  final double totalAmount; // Correspondance avec `totalAmount` au lieu de `amount`
  final TransactionStatus status;

  TransferResponseDto({
    required this.transactionId,
    required this.senderFullName,
    required this.receiverFullName,
    required this.totalAmount,
    required this.status,
  });

  factory TransferResponseDto.fromJson(Map<String, dynamic> json) => TransferResponseDto(
    transactionId: json['transactionId'] ?? 0,
    senderFullName: json['senderFullName'] ?? '',
    receiverFullName: json['receiverFullName'] ?? '',
    totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
    status: json['status'] != null
        ? TransactionStatus.values.firstWhere((e) => e.name == json['status'], orElse: () => TransactionStatus.UNKNOWN)
        : TransactionStatus.UNKNOWN,
  );
}


class TransactionListDto {
  final int id;
  final double montant;
  final String typeTransaction; // TRANSFERT ou RETRAIT
  final String statut; // EN_ATTENTE ou COMPLETE
  final DateTime dateCreation;
  final String autrePartiePrenante; // Nom de l'autre partie
  final bool estEmetteur; // True si l'utilisateur est l'émetteur

  TransactionListDto({
    required this.id,
    required this.montant,
    required this.typeTransaction,
    required this.statut,
    required this.dateCreation,
    required this.autrePartiePrenante,
    required this.estEmetteur,
  });

  factory TransactionListDto.fromJson(Map<String, dynamic> json) {
    return TransactionListDto(
      id: json['id'],
      montant: json['montant']?.toDouble() ?? 0.0,
      typeTransaction: json['typeTransaction'] ?? 'INCONNU',
      statut: json['statut'] ?? 'INCONNU',
      dateCreation: DateTime.parse(json['dateCreation']),
      autrePartiePrenante: json['autrePartiePrenante'] ?? '',
      estEmetteur: json['estEmetteur'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'montant': montant,
      'typeTransaction': typeTransaction,
      'statut': statut,
      'dateCreation': dateCreation.toIso8601String(),
      'autrePartiePrenante': autrePartiePrenante,
      'estEmetteur': estEmetteur,
    };
  }
}


class MultipleTransferRequestDto {
  final String senderPhoneNumber;
  final List<String> recipientPhoneNumbers;
  final double amount;
  final String? groupReference;

  MultipleTransferRequestDto({
    required this.senderPhoneNumber,
    required this.recipientPhoneNumbers,
    required this.amount,
    this.groupReference,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderPhoneNumber': senderPhoneNumber,
      'recipientPhoneNumbers': recipientPhoneNumbers,
      'amount': amount,
      'groupReference': groupReference,
    };
  }
}
class CancelTransactionRequestDto {
  final int transactionId;

  CancelTransactionRequestDto({required this.transactionId});

  Map<String, dynamic> toJson() => {
    'transactionId': transactionId,
  };
}

class CancelTransactionResponseDto {
  final int transactionId;
  final TransactionStatus status;

  CancelTransactionResponseDto({
    required this.transactionId,
    required this.status,
  });

  factory CancelTransactionResponseDto.fromJson(Map<String, dynamic> json) => CancelTransactionResponseDto(
    transactionId: json['transactionId'],
    status: TransactionStatus.values.firstWhere((e) => e.name == json['status']),
  );
}
