import 'dart:convert';

enum Periodicity { DAILY, WEEKLY, MONTHLY }
enum TransactionStatus { PENDING, COMPLETED, CANCELLED }
enum TransactionType { TRANSFER, DEPOSIT, WITHDRAWAL }

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
  final int id;
  final String senderPhoneNumber;
  final String recipientPhoneNumber;
  final double amount;
  final TransactionStatus status;

  TransferResponseDto({
    required this.id,
    required this.senderPhoneNumber,
    required this.recipientPhoneNumber,
    required this.amount,
    required this.status,
  });

  factory TransferResponseDto.fromJson(Map<String, dynamic> json) => TransferResponseDto(
    id: json['id'],
    senderPhoneNumber: json['senderPhoneNumber'],
    recipientPhoneNumber: json['recipientPhoneNumber'],
    amount: json['amount'],
    status: TransactionStatus.values.firstWhere((e) => e.name == json['status']),
  );
}

class TransactionListDto {
  final int id;
  final String senderPhoneNumber;
  final String recipientPhoneNumber;
  final double amount;
  final TransactionStatus status;
  final DateTime dateCreation; // Ajout de dateCreation

  TransactionListDto({
    required this.id,
    required this.senderPhoneNumber,
    required this.recipientPhoneNumber,
    required this.amount,
    required this.status,
    required this.dateCreation, // Initialisation dans le constructeur
  });

  factory TransactionListDto.fromJson(Map<String, dynamic> json) {
    return TransactionListDto(
      id: json['id'],
      senderPhoneNumber: json['senderPhoneNumber'],
      recipientPhoneNumber: json['recipientPhoneNumber'],
      amount: json['amount'],
      status: TransactionStatus.values.firstWhere((e) => e.name == json['status']),
      dateCreation: DateTime.parse(json['dateCreation']), // Conversion de la date depuis le JSON
    );
  }

  // Méthode pour vérifier si la transaction est reçue par l'utilisateur connecté
  bool isReceived(String currentUserPhoneNumber) {
    return recipientPhoneNumber == currentUserPhoneNumber;
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
