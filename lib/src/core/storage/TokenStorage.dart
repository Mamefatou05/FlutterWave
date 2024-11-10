import 'package:flutter_keychain/flutter_keychain.dart';

class TokenStorage {
  Future<void> saveToken(String token) async {
    await FlutterKeychain.put(key: 'jwt', value: token);
  }

  Future<String?> getToken() async {
    try {
      return await FlutterKeychain.get(key: 'jwt');
    } catch (e) {
      print("Erreur lors de la récupération du token: $e");
      return null;
    }
  }

  Future<void> deleteToken() async {
    await FlutterKeychain.remove(key: 'jwt');
  }
}
