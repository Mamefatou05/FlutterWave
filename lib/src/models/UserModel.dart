import 'package:flutter/foundation.dart';
import 'Marchand.dart';
import 'NumeroFavori.dart';
import 'Plafond.dart';
import 'PointAgent.dart';
import 'Role.dart';
import 'Transaction.dart';
import 'enums.dart';
import 'Notification.dart';

class UserModel {
  final int id;
  final String numeroTelephone;
  final String nomComplet;
  final String? email;
  final String password;
  final String? codeQr;
  final double solde;
  final bool estActif;
  final NotificationType typeNotification;
  final Role? role;
  final List<Transaction> transactionsEnvoyees;
  final List<Transaction> transactionsRecues;
  final List<NumeroFavori> numerosFavoris;
  final List<NotificationModel> notifications;
  final PointAgent? pointAgent;
  final Plafond? plafond;
  final Marchand? marchand;

  UserModel({
    required this.id,
    required this.numeroTelephone,
    required this.nomComplet,
    this.email,
    required this.password,
    this.codeQr,
    this.solde = 0.0,
    this.estActif = false,
    this.typeNotification = NotificationType.SMS,
    this.role,
    this.transactionsEnvoyees = const [],
    this.transactionsRecues = const [],
    this.numerosFavoris = const [],
    this.notifications = const [],
    this.pointAgent,
    this.plafond,
    this.marchand,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      // Vérification et conversion sécurisée de l'ID
      final id = json['id'];
      if (id == null) throw FormatException('ID is required');

      // Parse le type de notification de manière sécurisée
      NotificationType parseNotificationType(String? value) {
        if (value == null) return NotificationType.SMS;
        try {
          return NotificationType.values.firstWhere(
                (e) => e.toString().split('.').last == value,
            orElse: () => NotificationType.SMS,
          );
        } catch (e) {
          debugPrint('Error parsing notification type: $e');
          return NotificationType.SMS;
        }
      }

      // Parse les listes de manière sécurisée
      List<T> parseList<T>(List? jsonList, T Function(Map<String, dynamic>) fromJson) {
        if (jsonList == null) return [];
        try {
          return jsonList
              .where((item) => item != null)
              .map((item) => fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          debugPrint('Error parsing list of type $T: $e');
          return [];
        }
      }

      return UserModel(
        id: id,
        numeroTelephone: json['numeroTelephone']?.toString() ?? '',
        nomComplet: json['nomComplet']?.toString() ?? '',
        email: json['email']?.toString(),
        password: json['password']?.toString() ?? '',
        codeQr: json['codeQr']?.toString(),
        solde: (json['solde'] as num?)?.toDouble() ?? 0.0,
        estActif: json['estActif'] as bool? ?? false,
        typeNotification: parseNotificationType(json['typeNotification']?.toString()),
        role: json['role'] != null ? Role.fromJson(json['role'] as Map<String, dynamic>) : null,
        transactionsEnvoyees: parseList(
          json['transactionsEnvoyees'] as List?,
          Transaction.fromJson,
        ),
        transactionsRecues: parseList(
          json['transactionsRecues'] as List?,
          Transaction.fromJson,
        ),
        numerosFavoris: parseList(
          json['numerosFavoris'] as List?,
          NumeroFavori.fromJson,
        ),
        notifications: parseList(
          json['notifications'] as List?,
          NotificationModel.fromJson,
        ),
        pointAgent: json['pointAgent'] != null
            ? PointAgent.fromJson(json['pointAgent'] as Map<String, dynamic>)
            : null,
        plafond: json['plafond'] != null
            ? Plafond.fromJson(json['plafond'] as Map<String, dynamic>)
            : null,
        marchand: json['marchand'] != null
            ? Marchand.fromJson(json['marchand'] as Map<String, dynamic>)
            : null,
      );
    } catch (e, stackTrace) {
      debugPrint('Error parsing UserModel: $e');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('JSON data: $json');
      rethrow; // Relance l'erreur pour la gestion en amont
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroTelephone': numeroTelephone,
      'nomComplet': nomComplet,
      'email': email,
      'password': password,
      'codeQr': codeQr,
      'solde': solde,
      'estActif': estActif,
      'typeNotification': typeNotification.toString().split('.').last,
      'role': role?.toJson(),
      'transactionsEnvoyees': transactionsEnvoyees.map((t) => t.toJson()).toList(),
      'transactionsRecues': transactionsRecues.map((t) => t.toJson()).toList(),
      'numerosFavoris': numerosFavoris.map((n) => n.toJson()).toList(),
      'notifications': notifications.map((n) => n.toJson()).toList(),
      'pointAgent': pointAgent?.toJson(),
      'plafond': plafond?.toJson(),
      'marchand': marchand?.toJson(),
    };
  }

  @override
  String toString() {
    return '''UserModel(
      id: $id,
      numeroTelephone: $numeroTelephone,
      nomComplet: $nomComplet,
      email: $email,
      solde: $solde,
      estActif: $estActif,
      typeNotification: $typeNotification,
      role: ${role?.toString()},
      transactionsEnvoyees: ${transactionsEnvoyees.length} transactions,
      transactionsRecues: ${transactionsRecues.length} transactions,
      numerosFavoris: ${numerosFavoris.length} favoris,
      notifications: ${notifications.length} notifications,
      pointAgent: ${pointAgent != null ? 'Présent' : 'Absent'},
      plafond: ${plafond != null ? 'Présent' : 'Absent'},
      marchand: ${marchand != null ? 'Présent' : 'Absent'}
    )''';
  }
}