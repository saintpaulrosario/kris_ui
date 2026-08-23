import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/feature/authentication/logic/authenticate/bloc/authenticate_bloc.dart';
import 'package:kris/service_locator.dart';

import 'app_router.dart';
import 'feature/account/logic/user_account/user_account_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  await loadProfiles();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserAccountBloc()),
        BlocProvider(create: (context) => AuthenticateBloc()),
      ],
      child: MaterialApp.router(
        title: 'ߞߙߌߛ',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        routerConfig: appRouter,
      ),
    );
  }
}
