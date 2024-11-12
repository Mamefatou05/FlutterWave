import 'package:SenCash/src/services/UserService.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../../config.dart';
import '../../providers/UserProvider.dart';
import '../../repositories/ApiRepository.dart';
import '../../repositories/DioHttpClient.dart';
import '../../repositories/HttpClientHttp.dart';
import '../../repositories/HttpClientInterface.dart';
import '../../services/AuthService.dart';
import '../../services/ContactService.dart';
import '../../services/PlanificationTransfertService.dart';
import '../../services/QRCodeValidationService.dart';
import '../../services/TransactionService.dart';
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
    sl.registerLazySingleton<HttpClientInterface>(
          () => DioHttpClient(),
    );
  }

  else {
    sl.registerLazySingleton<HttpClientInterface>(
          () => HttpHttpClient(),
    );
  }

  // Repositories
  sl.registerLazySingleton<ApiRepository>(
        () => ApiRepository(
      httpClient: sl<HttpClientInterface>(),
      tokenStorage: sl<TokenStorageInterface>(),
    ),
  );

// Register Provider
  sl.registerLazySingleton<UserProvider>(() => UserProvider(sl<UserService>()));



  // Register services
  sl.registerLazySingleton<AuthService>(() => AuthService(
    apiRepository: sl<ApiRepository>(),
    tokenStorage: sl<TokenStorageInterface>(),
  ));

  // Register UserService
  sl.registerLazySingleton<UserService>(() => UserService(
    apiRepository: sl<ApiRepository>(),
  ));

   // Register TransactionService

  sl.registerLazySingleton<TransactionService>(() => TransactionService(
    apiRepository: sl<ApiRepository>(),
  ));

  // Register QRCodeValidationService
  sl.registerLazySingleton<QRCodeValidationService>(() => QRCodeValidationService(
    apiRepository: sl<ApiRepository>(),
  ));

  //Register PlanificationTransfertService
  sl.registerLazySingleton<PlanificationTransfertService>(() => PlanificationTransfertService(
    apiRepository: sl<ApiRepository>(),
  ));
  sl.registerLazySingleton(() => ContactService());



  print("Service Locator setup completed.");
}
