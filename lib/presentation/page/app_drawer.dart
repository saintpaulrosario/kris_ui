import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: Text("ߞߎߞߎߟߞߊ߲"),
            accountEmail: Text("saintpaulrosario@gmail.com"),
            onDetailsPressed: () {
              // Optionally expand details
            },
            currentAccountPicture: GestureDetector(
              onTap: () {
                // Optionally show profile or avatar picker
              },
              child: CircleAvatar(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to settings page
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              //context.read<AccountBloc>().add(AccountLoggedOut());
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language_sharp),
            title: Text("scripts"),
          ),

          ListTile(
            leading: const Icon(Icons.wordpress_outlined),
            title: Text("Languages"),
          ),

          ListTile(
            leading: const Icon(Icons.noise_aware),
            title: Text("dialects"),
          ),
        ],
      ),
    );
  }
}
