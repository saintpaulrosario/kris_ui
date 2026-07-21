import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:yaml/yaml.dart';

import 'logic/content/bloc/content_bloc.dart';
import 'logic/content/content_api.dart';
import 'logic/content/content_service.dart';

import 'logic/example/example_api.dart';
import 'logic/example/example_service.dart';

import 'logic/example_content/example_content_api.dart';
import 'logic/example_content/example_content_service.dart';

import 'logic/example_payload/example_payload_api.dart';
import 'logic/example_payload/example_payload_service.dart';

import 'logic/example_text/example_text_api.dart';
import 'logic/example_text/example_text_service.dart';

import 'logic/image/image_api.dart';
import 'logic/image/image_service.dart';

import 'logic/payload/bloc/payload_bloc.dart';
import 'logic/payload/payload_api.dart';
import 'logic/payload/payload_service.dart';

import 'logic/sound/sound_api.dart';
import 'logic/sound/sound_service.dart';

import 'logic/text/bloc/word_text_bloc.dart';
import 'logic/text/word_text_api.dart';
import 'logic/text/word_text_service.dart';

import 'logic/word/bloc/word_bloc.dart';
import 'logic/word/word_api.dart';
import 'logic/word/word_service.dart';

final GetIt getIt = GetIt.instance;

///------------------------------------------------------------
/// Application Configuration
///------------------------------------------------------------

class AppConfig {
  final String baseUrl;

  const AppConfig({required this.baseUrl});
}

late final AppConfig appConfig;

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
  const baseUrl = String.fromEnvironment('KRIS_BASE_URL', defaultValue: '');

  if (baseUrl.isNotEmpty) {
    appConfig = AppConfig(baseUrl: baseUrl);
    return;
  }

  const activeProfile = String.fromEnvironment(
    'ACTIVE_PROFILE',
    defaultValue: 'web',
  );

  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'develop',
  );

  appConfig = await _loadProperties(
    activeProfile: activeProfile,
    environment: environment,
  );
}

Future<AppConfig> _loadProperties({
  required String activeProfile,
  required String environment,
}) async {
  final logger = getIt<Logger>();

  logger.i("Active profile: $activeProfile");
  logger.i("Environment: $environment");

  final configFile = 'profiles/$environment/application_$activeProfile.yaml';

  final yamlString = await rootBundle.loadString(configFile);

  final yaml = loadYaml(yamlString);

  final properties = Map<String, dynamic>.from(yaml);

  logger.i("Loaded properties: $properties");

  final baseUrl = properties['KRIS_BASE_URL'];

  if (baseUrl == null || baseUrl.toString().isEmpty) {
    throw Exception('KRIS_BASE_URL is missing from $configFile');
  }

  return AppConfig(baseUrl: baseUrl.toString());
}

///------------------------------------------------------------
/// Dependency Registration
///------------------------------------------------------------

void setupLocator() {
  if (!getIt.isRegistered<AppConfig>()) {
    getIt.registerSingleton<AppConfig>(appConfig);
  }

  _registerCore();

  final dio = getIt<Dio>();

  _registerApis(dio: dio, baseUrl: appConfig.baseUrl);

  _registerServices();

  _registerBlocs();
}

///------------------------------------------------------------
/// Core
///------------------------------------------------------------

void _registerCore() {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: appConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {'Accept': 'application/json'},
        ),
      ),
    );
  }
}

///------------------------------------------------------------
/// APIs
///------------------------------------------------------------

void _registerApis({required Dio dio, required String baseUrl}) {
  getIt.registerLazySingleton<WordApi>(() => WordApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<ImageApi>(() => ImageApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<SoundApi>(() => SoundApi(dio, baseUrl: baseUrl));

  getIt.registerLazySingleton<ContentApi>(
    () => ContentApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<WordTextApi>(
    () => WordTextApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<PayloadApi>(
    () => PayloadApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ExampleApi>(
    () => ExampleApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ExampleContentApi>(
    () => ExampleContentApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ExampleTextApi>(
    () => ExampleTextApi(dio, baseUrl: baseUrl),
  );

  getIt.registerLazySingleton<ExamplePayloadApi>(
    () => ExamplePayloadApi(dio, baseUrl: baseUrl),
  );
}

///------------------------------------------------------------
/// Services
///------------------------------------------------------------

void _registerServices() {
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

  getIt.registerLazySingleton<ExamplePayloadService>(
    () => ExamplePayloadService(),
  );
}

///------------------------------------------------------------
/// BLoCs
///------------------------------------------------------------

void _registerBlocs() {
  getIt.registerLazySingleton<ContentBloc>(() => ContentBloc());

  getIt.registerLazySingleton<WordTextBloc>(() => WordTextBloc());

  getIt.registerLazySingleton<WordBloc>(() => WordBloc());

  getIt.registerLazySingleton<PayloadBloc>(() => PayloadBloc());
}
