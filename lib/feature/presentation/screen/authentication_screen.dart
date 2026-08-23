import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/feature/account/logic/user_account/user_account_bloc.dart';

import 'package:kris/feature/authentication/logic/authenticate/bloc/authenticate_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final secretController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('login_screen.login'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticateBloc, AuthenticateState>(
            listener: (context, state) {
              if (state.fetching) {
                return;
              }

              if (!state.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("error"),
                    backgroundColor: Colors.red[50],
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 4),
                  ),
                );
              } else if (state.success) {
                context.read()<UserAccountBloc>().add(
                  UserAccountEventAuthenticated(
                    accessToken: state.authenticateResponse.accessToken,
                  ),
                );
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop(); // Close login screen
              }
            },
          ),
        ],
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'login_screen.email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: secretController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'login_screen.secret',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticateBloc>().add(
                      AuthenticateEvent(
                        email: emailController.text.trim(),
                        secret: secretController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'login_screen.login',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    // TODO: Forgot password logic
                  },
                  child: Text('login_screen.forgot_password'),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('login_screen.no_account'),
                    TextButton(
                      onPressed: () {
                        // TODO: Navigate to sign-up screen using GoRouter
                        // context.go('/signup');
                      },
                      child: Text('login_screen.signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
