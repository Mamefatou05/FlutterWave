import '../core/storage/TokenStorageInterface.dart';

class TokenService {
  final TokenStorageInterface _tokenStorage;
  String? _cachedToken;
  String? _cachedRefreshToken;

  TokenService(this._tokenStorage);

  Future<String?> getAccessToken() async {
    if (_cachedToken != null) return _cachedToken;
    _cachedToken = await _tokenStorage.getToken();
    return _cachedToken;
  }

  Future<String?> getRefreshToken() async {
    if (_cachedRefreshToken != null) return _cachedRefreshToken;
    _cachedRefreshToken = await _tokenStorage.getRefreshToken();
    return _cachedRefreshToken;
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    _cachedToken = accessToken;
    _cachedRefreshToken = refreshToken;
    await _tokenStorage.saveToken(accessToken);
    await _tokenStorage.saveRefreshToken(refreshToken);
  }

  Future<void> clearTokens() async {
    _cachedToken = null;
    _cachedRefreshToken = null;
    await _tokenStorage.deleteAllTokens();
  }
}
