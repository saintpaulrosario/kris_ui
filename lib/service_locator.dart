import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:kris/logic/medium/medium_api.dart';
import 'package:kris/logic/medium/service/medium_service.dart';

import 'package:kris/logic/word/api/dialect_api.dart';
import 'package:kris/logic/word/api/language_api.dart';
import 'package:kris/logic/word/api/script_api.dart';
import 'package:kris/logic/word/api/translation_api.dart';
import 'package:kris/logic/word/service/dialect_service.dart';
import 'package:kris/logic/word/service/language_service.dart';
import 'package:kris/logic/word/service/script_service.dart';
import 'package:kris/logic/word/service/translation_service.dart';

import 'package:kris/logic/word/service/word_service.dart';
import 'package:kris/model/word_image.dart';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

import 'logic/medium/image_api.dart';
import 'logic/medium/image_service.dart';
import 'logic/word/api/word_api.dart';

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
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();

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

    return dio;
  });

  final dio = getIt<Dio>();
  //String baseUrl = "http://192.168.12.59:8080";
  final baseUrl = properties['KRIS_BASE_URL']!;

  getIt.registerLazySingleton<WordApi>(() => WordApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<ScriptApi>(
    () => ScriptApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<DialectApi>(
    () => DialectApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ImageApi>(() => ImageApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<TranslationApi>(
    () => TranslationApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<LanguageApi>(
    () => LanguageApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<MediumApi>(
    () => MediumApi(dio, baseUrl: baseUrl),
  );
}

///------------------------------------------------------------
/// Services
///------------------------------------------------------------

void _registerServices() {
  getIt.registerLazySingleton<ImageService<WordImage>>(() => ImageService());

  getIt.registerLazySingleton<MediumService>(() => MediumService());

  getIt.registerLazySingleton<WordService>(() => WordService());

  getIt.registerLazySingleton<TranslationService>(() => TranslationService());

  getIt.registerLazySingleton<ScriptService>(() => ScriptService());

  getIt.registerLazySingleton<LanguageService>(() => LanguageService());

  getIt.registerLazySingleton<DialectService>(() => DialectService());
}
