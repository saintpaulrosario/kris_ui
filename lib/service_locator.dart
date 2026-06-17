import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kris/data/api/script_api.dart';

import 'data/service/script_service.dart';

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

  final dio = getIt<Dio>();
  final base_url_kris = 'http://192.168.12.232:8080';
  // APIs

  getIt.registerLazySingleton<ScriptApi>(
    () => ScriptApi(dio, baseUrl: base_url_kris),
  );
  // getIt.registerLazySingleton<TopicApi>(
  //   () => TopicApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<CommunityApi>(
  //   () => CommunityApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<DiscussionApi>(
  //   () => DiscussionApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<CommentApi>(
  //   () => CommentApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<ImageApi>(
  //   () => ImageApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<ProfileApi>(
  //   () => ProfileApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<WordApi>(
  //   () => WordApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<SoundApi>(
  //   () => SoundApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<Api.ImageApi>(
  //   () => Api.ImageApi(dio, baseUrl: tenin_baseUrl),
  // );
  // //getIt.registerLazySingleton<TranslationApi>(() => TranslationApi(dio,baseUrl: tenin_baseUrl));
  // getIt.registerLazySingleton<LanguageApi>(
  //   () => LanguageApi(dio, baseUrl: tenin_baseUrl),
  // );
  // //getIt.registerLazySingleton<TypeApi>(() => TypeApi(dio,baseUrl: tenin_baseUrl));
  // getIt.registerLazySingleton<ScriptApi>(
  //   () => ScriptApi(dio, baseUrl: tenin_baseUrl),
  // );
  // getIt.registerLazySingleton<DialectApi>(
  //   () => DialectApi(dio, baseUrl: tenin_baseUrl),
  // );

  // getIt.registerLazySingleton<SenbaApi>(
  //   () => SenbaApi(dio, baseUrl: senba_baseUrl),
  // );

  // // Services
  getIt.registerLazySingleton<ScriptService>(() => ScriptService());
}
