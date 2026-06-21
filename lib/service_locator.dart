import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kris/data/api/script_api.dart';

import 'data/service/script_service.dart';
import 'logic/image/image_api.dart';
import 'logic/image/image_service.dart';
import 'logic/word/word_api.dart';
import 'logic/word/word_service.dart';

final getIt = GetIt.instance;
void setupLocator() {
  // final tenin_baseUrl = appProperties['TENIN_BASE_URL'];
  // final wulu_baseUrl = appProperties['WULU_BASE_URL'];
  // final senba_baseUrl = appProperties['SENBA_BASE_URL'];
  // if (tenin_baseUrl == null || tenin_baseUrl.isEmpty) {
  //   throw Exception('TENIN_BASE_URL is not set in appProperties');
  // }

  // Core dependencies
  // getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService());

  // getIt.registerLazySingleton<AuthInterceptor>(() => AuthInterceptor());

  // getIt.registerLazySingleton<DioClient>(
  //   () => DioClient(getIt<AuthInterceptor>()),
  // );

  final baseUrlKris = 'http://127.0.0.1:8080';
  // APIs

  getIt.registerLazySingleton<Dio>(() => Dio());
  final dio = getIt<Dio>();

  getIt.registerLazySingleton<ScriptApi>(
    () => ScriptApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<WordApi>(
    () => WordApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ImageApi>(
    () => ImageApi(dio, baseUrl: baseUrlKris),
  );

  // // Services
  getIt.registerLazySingleton<ScriptService>(() => ScriptService());
  getIt.registerLazySingleton<WordService>(() => WordService());
  getIt.registerLazySingleton<ImageService>(() => ImageService());
}
