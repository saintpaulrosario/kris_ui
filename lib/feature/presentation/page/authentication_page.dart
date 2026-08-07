import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/feature/authentication/logic/authenticate/bloc/authenticate_bloc.dart';

import '../screen/authentication_screen.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => AuthenticateBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Sign In'),
              Tab(text: 'Sign Up'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [AuthenticationScreen(), Text("registeer")],
        ),
      ),
    );
  }
}
