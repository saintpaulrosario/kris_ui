import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kris/service_locator.dart';
import 'package:yaml/yaml.dart';

import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String baseUrl = String.fromEnvironment('KRIS_BASE_URL', defaultValue: '');
  if (baseUrl.isNotEmpty) {
    appProperties["KRIS_BASE_URL"] = baseUrl;
  } else {
    const String activeProfile = String.fromEnvironment(
      'ACTIVE_PROFILE',
      defaultValue: 'local',
    );
    const String environment = String.fromEnvironment(
      'ACTIVE_PROFILE',
      defaultValue: 'web',
    );
    await AppProfileConfig.load(activeProfile, environment);
  }
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ߞߙߌߛߌ',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter,
    );
  }
}

Map<String, dynamic> appProperties = {};

class AppProfileConfig {
  static Future<Map<String, dynamic>> load(
    String activeProfile,
    String environment,
  ) async {
    log("the active profile is : $activeProfile");
    String configFile = 'profiles/$activeProfile/application_$environment.yaml';
    String yamlString = await rootBundle.loadString(configFile);
    var yaml = loadYaml(yamlString);
    var res = Map<String, dynamic>.from(yaml);
    log("profile properties are $res");
    appProperties = res;
    return res;
  }
}
