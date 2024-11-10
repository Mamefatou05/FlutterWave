import 'package:flutter_keychain/flutter_keychain.dart';
import 'TokenStorageInterface.dart';

class TokenStorageKeychain implements TokenStorageInterface {
  @override
  Future<void> saveToken(String token) async {
    await FlutterKeychain.put(key: 'jwt', value: token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await FlutterKeychain.put(key: 'refresh_token', value: refreshToken);
  }

  @override
  Future<String?> getToken() async {
    return await FlutterKeychain.get(key: 'jwt');
  }

  @override
  Future<String?> getRefreshToken() async {
    return await FlutterKeychain.get(key: 'refresh_token');
  }

  @override
  Future<void> deleteToken() async {
    await FlutterKeychain.remove(key: 'jwt');
  }

  @override
  Future<void> deleteRefreshToken() async {
    await FlutterKeychain.remove(key: 'refresh_token');
  }

  @override
  Future<void> deleteAllTokens() async {
    await FlutterKeychain.remove(key: 'jwt');
    await FlutterKeychain.remove(key: 'refresh_token');
  }
}
