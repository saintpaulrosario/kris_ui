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

  _registerBlocs();
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
