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
import '../../services/HiveService.dart';
import '../../services/PlanificationTransfertService.dart';
import '../../services/QRCodeValidationService.dart';
import '../../services/TransactionService.dart';
import '../storage/TokenStorageHive.dart';
import '../storage/TokenStorageInterface.dart';
import '../storage/TokenStorageKeychain.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator({bool useDioClient = true}) async {

  // Initialisez Hive avec Hive Flutter
  await Hive.initFlutter();
   // await Hive.close(); // Ferme toutes les boîtes ouvertes
  //  await Hive.deleteFromDisk(); // Supprime toutes les boîtes stockées localement
   // print("Toutes les boîtes Hive ont été supprimées.");

  // Register HiveService
  try {
    sl.registerLazySingleton(() => HiveService('securebox'));
  } catch (e, stackTrace) {
    print("Error while creating HiveService: $e");
    print("Stack trace: $stackTrace");
  }
  // Choisissez TokenStorage en fonction de la configuration
  bool useFlutterSecureStorage = false;
  if (useFlutterSecureStorage) {
    sl.registerLazySingleton<TokenStorageInterface>(() => TokenStorageKeychain());
  } else {
    sl.registerLazySingleton<TokenStorageInterface>(
          () => TokenStorageHive(hiveService: sl<HiveService>()),
    );
  }

  // Enregistrez les clients HTTP
  if (useDioClient) {
    sl.registerLazySingleton<HttpClientInterface>(() => DioHttpClient());
  } else {
    sl.registerLazySingleton<HttpClientInterface>(() => HttpHttpClient());
  }

  // Enregistrez les repositories
  sl.registerLazySingleton<ApiRepository>(
        () => ApiRepository(
      httpClient: sl<HttpClientInterface>(),
      tokenStorage: sl<TokenStorageInterface>(),
    ),
  );

  // Enregistrez les providers
  sl.registerLazySingleton<UserProvider>(() => UserProvider(sl<UserService>()));

  // Enregistrez les services
  sl.registerLazySingleton<AuthService>(() => AuthService(
    apiRepository: sl<ApiRepository>(),
    tokenStorage: sl<TokenStorageInterface>(),
  ));

  sl.registerLazySingleton<UserService>(() => UserService(
    apiRepository: sl<ApiRepository>(),
  ));

  sl.registerLazySingleton<TransactionService>(() => TransactionService(
    apiRepository: sl<ApiRepository>(),
  ));

  sl.registerLazySingleton<QRCodeValidationService>(() => QRCodeValidationService(
    apiRepository: sl<ApiRepository>(),
  ));

  sl.registerLazySingleton<PlanificationTransfertService>(() => PlanificationTransfertService(
    apiRepository: sl<ApiRepository>(),
  ));

  sl.registerLazySingleton(() => ContactService());

  print("Service Locator setup completed.");
}
