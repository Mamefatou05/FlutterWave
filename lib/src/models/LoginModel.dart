class LoginModel {
  final String telephone;
  final String password;

  LoginModel({required this.telephone, required this.password});

  Map<String, dynamic> toJson() => {
        "username": telephone,
        "password": password,
      };
}
