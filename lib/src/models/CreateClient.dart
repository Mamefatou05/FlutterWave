import 'NotificationTypeModel.dart';

class CreateClient {
  final String nomComplet;
  final String numeroTelephone;
  final String email;
  final String password;
  final String confirmPassword;
  final NotificationType type;

  CreateClient({
    required this.nomComplet,
    required this.numeroTelephone,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'nomComplet': nomComplet,
      'numeroTelephone': numeroTelephone,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'type': type.toString().split('.').last, // Convert enum to string
    };
  }

  factory CreateClient.fromJson(Map<String, dynamic> json) {
    return CreateClient(
      nomComplet: json['nomComplet'],
      numeroTelephone: json['numeroTelephone'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      type: NotificationType.values.firstWhere(
            (e) => e.toString() == 'NotificationType.${json['type']}',
      ),
    );
  }
}
