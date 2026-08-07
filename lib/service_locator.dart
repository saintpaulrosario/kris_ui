import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:kris/api/language_api.dart';
import 'package:kris/api/translation_api.dart';
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

import 'api/dialect_api.dart';
import 'api/script_api.dart';
import 'logic/image/image_api.dart';
import 'logic/image/image_service.dart';

import 'logic/sound/sound_api.dart';
import 'logic/sound/sound_service.dart';


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
  //String baseUrl = "http://192.168.12.59:8080";
  final baseUrl = properties['KRIS_BASE_URL']!;

  getIt.registerLazySingleton<TranslationApi>(
    () => TranslationApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ImageApi>(() => ImageApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<SoundApi>(() => SoundApi(dio, baseUrl: baseUrl));
  getIt.registerLazySingleton<ScriptApi>(
    () => ScriptApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<LanguageApi>(
    () => LanguageApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<DialectApi>(
    () => DialectApi(dio, baseUrl: baseUrl),
  );
}

///------------------------------------------------------------
/// Services
///------------------------------------------------------------

void _registerServices() {
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
        >(getIt<LanguageApi>()),
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
        >(getIt<ScriptApi>()),
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
        >(getIt<TranslationApi>()),
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
        >(getIt<DialectApi>()),
  );
}
