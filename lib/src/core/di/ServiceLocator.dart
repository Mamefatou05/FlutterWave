import 'package:SenCash/src/services/UserService.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../../config.dart';
import '../../repositories/ApiRepository.dart';
import '../../services/AuthService.dart';
import '../storage/TokenStorageHive.dart';
import '../storage/TokenStorageInterface.dart';
import '../storage/TokenStorageKeychain.dart';

final GetIt sl = GetIt.instance;
Future<void> setupServiceLocator({bool useDioClient = true}) async {
  print("Initializing Hive...");
  await Hive.initFlutter();
  await Hive.openBox<String>('secureBox');
  print("Hive initialized.");

  // Choose TokenStorage based on configuration
  bool useFlutterSecureStorage = false;
  if (useFlutterSecureStorage) {
    sl.registerLazySingleton<TokenStorageInterface>(() => TokenStorageKeychain());
  } else {
    sl.registerLazySingleton<TokenStorageInterface>(() => TokenStorageHive());
  }

  if (useDioClient) {
    sl.registerLazySingleton<Dio>(() => Dio());
  } else {
    sl.registerLazySingleton<http.Client>(() => http.Client());
  }

  sl.registerLazySingleton<ApiRepository>(() => ApiRepository(
    dio: useDioClient ? sl<Dio>() : null,
    httpClient: useDioClient ? null : sl<http.Client>(),
    tokenStorage: sl<TokenStorageInterface>(),
    useDio: useDioClient,
  ));

  // Register services
  sl.registerLazySingleton<AuthService>(() => AuthService(
    apiRepository: sl<ApiRepository>(),
    tokenStorage: sl<TokenStorageInterface>(),
  ));

  // Register UserService
  sl.registerLazySingleton<UserService>(() => UserService(
    apiRepository: sl<ApiRepository>(),
  ));

  print("Service Locator setup completed.");
}
