import 'dart:convert';

import 'NotificationTypeModel.dart';

class UserModel {
  final String numeroTelephone;
  final String nomComplet;
  final String? email;
  final String password;
  final String? codeQr;
  final double solde;
  final RoleModel role;
  final bool estActif;
  final NotificationType typeNotification;

  UserModel({
    required this.numeroTelephone,
    required this.nomComplet,
    this.email,
    required this.password,
    this.codeQr,
    this.solde = 0.0,
    required this.role,
    this.estActif = false,
    this.typeNotification = NotificationType.SMS,
  });

  // Conversion depuis un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      numeroTelephone: json['numeroTelephone'] ?? '',
      nomComplet: json['nomComplet'] ?? '',
      email: json['email'],
      password: json['password'] ?? '',
      codeQr: json['codeQr'],
      solde: (json['solde'] as num?)?.toDouble() ?? 0.0,
      role: RoleModel.fromJson(json['role']),
      estActif: json['estActif'] ?? false,
      typeNotification: NotificationType.values.firstWhere(
              (e) => e.toString().split('.').last == json['typeNotification'],
          orElse: () => NotificationType.SMS),
    );
  }

  // Conversion vers un JSON
  Map<String, dynamic> toJson() {
    return {
      'numeroTelephone': numeroTelephone,
      'nomComplet': nomComplet,
      'email': email,
      'password': password,
      'codeQr': codeQr,
      'solde': solde,
      'role': role.toJson(),
      'estActif': estActif,
      'typeNotification': typeNotification.toString().split('.').last,
    };
  }
}

class RoleModel {
  final int id;
  final String name;

  RoleModel({
    required this.id,
    required this.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

