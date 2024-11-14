import '../../services/HiveService.dart';
import 'TokenStorageInterface.dart';

class TokenStorageHive implements TokenStorageInterface {
  final HiveService _hiveService;
  TokenStorageHive({required HiveService hiveService}) : _hiveService = hiveService;

  @override
  Future<void> saveToken(String token) async {
    await _hiveService.saveData<String>('jwt', token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _hiveService.saveData<String>('refresh_token', refreshToken);
  }

  @override
  Future<String?> getToken() async {
    return _hiveService.getData<String>('jwt');
  }

  @override
  Future<String?> getRefreshToken() async {
    return _hiveService.getData<String>('refresh_token');
  }

  @override
  Future<void> deleteToken() async {
    await _hiveService.deleteData('jwt');
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _hiveService.deleteData('refresh_token');
  }

  @override
  Future<void> deleteAllTokens() async {
    await _hiveService.deleteData('jwt');
    await _hiveService.deleteData('refresh_token');
  }
}
