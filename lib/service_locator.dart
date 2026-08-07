import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:kris/feature/authentication/api/authentication_api.dart';

import 'package:kris/logic/word_service.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/translation_content.dart';
import 'package:kris/model/translation_payload.dart';
import 'package:kris/model/translation_text.dart';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

import 'feature/authentication/logic/authenticate/authenticate_service.dart';
import 'logic/image/image_api.dart';
import 'logic/image/image_service.dart';

import 'logic/sound/sound_api.dart';
import 'logic/sound/sound_service.dart';

import 'logic/translation/bloc/translation_bloc.dart';
import 'api/word_api.dart';

final GetIt getIt = GetIt.instance;

///------------------------------------------------------------
/// Application Configuration
///------------------------------------------------------------

Map<String, String> properties = {};

///------------------------------------------------------------
/// Logger
///------------------------------------------------------------

void setupLogger() {
  if (!getIt.isRegistered<Logger>()) {
    getIt.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  }
}

///------------------------------------------------------------
/// Load Configuration
///------------------------------------------------------------

Future<void> loadProfiles() async {
  //const baseUrl = String.fromEnvironment('KRIS_BASE_URL', defaultValue: '');

  const activeProfile = String.fromEnvironment(
    'ACTIVE_PROFILE',
    defaultValue: 'web',
  );

  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'local',
  );

  await loadProperties(activeProfile: activeProfile, environment: environment);
}

Future<Map<String, String>> loadProperties({
  required String activeProfile,
  required String environment,
}) async {
  final logger = getIt<Logger>();

  logger.i('Active profile: $activeProfile');
  logger.i('Environment: $environment');

  final configFile = 'profiles/$environment/application_$activeProfile.yaml';

  final yamlString = await rootBundle.loadString(configFile);

  final yaml = loadYaml(yamlString);

  final props = Map<String, String>.from(yaml);

  logger.i('Loaded properties: $props');

  final baseUrl = props['KRIS_BASE_URL'];

  if (baseUrl == null || baseUrl.toString().isEmpty) {
    throw Exception('KRIS_BASE_URL missing from $configFile');
  }
  properties = props;
  return properties;
}

///------------------------------------------------------------
/// Dependency Registration
///------------------------------------------------------------

void setupLocator() {
  _registerApis();

  _registerServices();
}

///------------------------------------------------------------
/// Core
///------------------------------------------------------------

///------------------------------------------------------------
/// APIs
///------------------------------------------------------------

void _registerApis() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  final dio = getIt<Dio>();
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );
  //String baseUrl = "http://192.168.12.59:8080";
  final baseUrl = properties['KRIS_BASE_URL']!;
  getIt.registerLazySingleton<AuthenticationApi>(
    () => AuthenticationApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<
    WordApi<Language, TranslationText, TranslationContent, TranslationPayload>
  >(
    () =>
        WordApi<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(dio, baseUrl: baseUrl),
    instanceName: "languageApi",
  );

  getIt.registerLazySingleton<
    WordApi<Script, TranslationText, TranslationContent, TranslationPayload>
  >(
    () =>
        WordApi<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(dio, baseUrl: baseUrl),
    instanceName: "scriptApi",
  );

  getIt.registerLazySingleton<
    WordApi<
      Translation,
      TranslationText,
      TranslationContent,
      TranslationPayload
    >
  >(
    () =>
        WordApi<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(dio, baseUrl: baseUrl),
    instanceName: "translationApi",
  );

  getIt.registerLazySingleton<
    WordApi<Dialect, TranslationText, TranslationContent, TranslationPayload>
  >(
    () =>
        WordApi<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(dio, baseUrl: baseUrl),
    instanceName: "dialectApi",
  );

  getIt.registerLazySingleton<ImageApi>(() => ImageApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<SoundApi>(() => SoundApi(dio, baseUrl: baseUrl));
}

///------------------------------------------------------------
/// Services
///------------------------------------------------------------

void _registerServices() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<ImageService>(() => ImageService());

  getIt.registerLazySingleton<SoundService>(() => SoundService());

  getIt.registerLazySingleton<
    WordService<
      Language,
      TranslationText,
      TranslationContent,
      TranslationPayload
    >
  >(
    () =>
        WordService<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(
          getIt<
            WordApi<
              Language,
              TranslationText,
              TranslationContent,
              TranslationPayload
            >
          >(instanceName: "languageApi"),
        ),
  );

  getIt.registerLazySingleton<
    WordService<Script, TranslationText, TranslationContent, TranslationPayload>
  >(
    () =>
        WordService<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(
          getIt<
            WordApi<
              Script,
              TranslationText,
              TranslationContent,
              TranslationPayload
            >
          >(instanceName: "scriptApi"),
        ),
  );

  getIt.registerLazySingleton<
    WordService<
      Translation,
      TranslationText,
      TranslationContent,
      TranslationPayload
    >
  >(
    () =>
        WordService<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(
          getIt<
            WordApi<
              Translation,
              TranslationText,
              TranslationContent,
              TranslationPayload
            >
          >(instanceName: "translationApi"),
        ),
  );

  getIt.registerLazySingleton<
    WordService<
      Dialect,
      TranslationText,
      TranslationContent,
      TranslationPayload
    >
  >(
    () =>
        WordService<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >(
          getIt<
            WordApi<
              Dialect,
              TranslationText,
              TranslationContent,
              TranslationPayload
            >
          >(instanceName: "dialectApi"),
        ),
  );
}
