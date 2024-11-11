import 'BaseModel.dart';
import 'TrasactionModel.dart';
import 'UserModel.dart';

class NotificationModel extends BaseModel {
  final UserModel utilisateur;
  final String titre;
  final String message;
  final bool estLue;
  final TransactionType? typeNotification;

  NotificationModel({
    required super.id,
    required super.dateCreation,
    super.dateModification,
    required this.utilisateur,
    required this.titre,
    required this.message,
    required this.estLue,
    this.typeNotification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      dateCreation: DateTime.parse(json['dateCreation']),
      dateModification: json['dateModification'] != null
          ? DateTime.parse(json['dateModification'])
          : null,
      utilisateur: UserModel.fromJson(json['utilisateur']),
      titre: json['titre'],
      message: json['message'],
      estLue: json['estLue'],
      typeNotification: json['typeNotification'] != null
          ? TransactionType.values.firstWhere((e) =>
      e.toString() == 'TransactionType.${json['typeNotification']}')
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'utilisateur': utilisateur.toJson(),
      'titre': titre,
      'message': message,
      'estLue': estLue,
      'typeNotification': typeNotification?.toString().split('.').last,
    };
  }
}
