import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:kris/logic/example/example_api.dart';
import 'package:kris/logic/example/example_service.dart';
import 'package:kris/logic/example_content/example_content_api.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';

import 'logic/content/bloc/content_bloc.dart';
import 'logic/content/content_api.dart';
import 'logic/content/content_service.dart';
import 'logic/example_content/example_content_service.dart';
import 'logic/example_payload/example_payload_api.dart';
import 'logic/example_text/example_text_api.dart';
import 'logic/example_text/example_text_service.dart';
import 'logic/image/image_api.dart';
import 'logic/image/image_service.dart';
import 'logic/payload/bloc/payload_bloc.dart';
import 'logic/payload/payload_api.dart';
import 'logic/payload/payload_service.dart';
import 'logic/text/bloc/word_text_bloc.dart';
import 'logic/text/word_text_api.dart';
import 'logic/text/word_text_service.dart';
import 'logic/word/word_api.dart';
import 'logic/word/word_service.dart';
import 'logic/sound/sound_api.dart';
import 'logic/sound/sound_service.dart';

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

  final baseUrlKris = 'http://192.168.12.59:8080';
  // APIs

  getIt.registerLazySingleton<Dio>(() => Dio());
  final dio = getIt<Dio>();

  getIt.registerLazySingleton<WordApi>(
    () => WordApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ImageApi>(
    () => ImageApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<SoundApi>(
    () => SoundApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ContentApi>(
    () => ContentApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<WordTextApi>(
    () => WordTextApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<PayloadApi>(
    () => PayloadApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ExampleApi>(
    () => ExampleApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ExampleContentApi>(
    () => ExampleContentApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ExampleTextApi>(
    () => ExampleTextApi(dio, baseUrl: baseUrlKris),
  );

  getIt.registerLazySingleton<ExamplePayloadApi>(
    () => ExamplePayloadApi(dio, baseUrl: baseUrlKris),
  );

  // // Services
  getIt.registerLazySingleton<WordService>(() => WordService());
  getIt.registerLazySingleton<ImageService>(() => ImageService());
  getIt.registerLazySingleton<SoundService>(() => SoundService());
  getIt.registerLazySingleton<ContentService>(() => ContentService());
  getIt.registerLazySingleton<WordTextService>(() => WordTextService());
  getIt.registerLazySingleton<PayloadService>(() => PayloadService());
  getIt.registerLazySingleton<ExampleService>(() => ExampleService());
  getIt.registerLazySingleton<ExampleContentService>(
    () => ExampleContentService(),
  );

  getIt.registerLazySingleton<ExampleTextService>(() => ExampleTextService());

  getIt.registerLazySingleton<ExampleTextService>(() => ExampleTextService());

  //
  getIt.registerLazySingleton<ContentBloc>(() => ContentBloc());
  getIt.registerLazySingleton<WordTextBloc>(() => WordTextBloc());
  getIt.registerLazySingleton<WordBloc>(() => WordBloc());
  getIt.registerLazySingleton<PayloadBloc>(() => PayloadBloc());
}
