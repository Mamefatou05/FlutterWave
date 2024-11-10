class JwtModel {
  final String token;

  JwtModel({required this.token});

  factory JwtModel.fromJson(Map<String, dynamic> json) {
    return JwtModel(
      token: json['accessToken'] ?? '', // Valeur par défaut pour éviter les `null`
    );
  }
}
