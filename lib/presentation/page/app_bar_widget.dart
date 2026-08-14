import 'package:flutter/material.dart';

import '../../feature/presentation/page/authentication_page.dart';
import 'menu_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      toolbarHeight: 220,

      backgroundColor: Colors.white,

      actions: [
        Text("john"),
        Visibility(
          visible: true,
          child: IconButton(
            icon: const Icon(Icons.login),
            color: Colors.black,
            onPressed: () {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (ctx) => Dialog(
                  insetPadding: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: size.width * 0.9,
                    height: size.height * 0.8,
                    child: const AuthenticationPage(),
                  ),
                ),
              );
            },
          ),
        ),

        Visibility(
          visible: true,
          child: IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.black,
            onPressed: () {
              // TODO logout
            },
          ),
        ),

        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // Add your search functionality here
          },
        ),
        Badge(
          label: const Text("4"),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {
              //context.go('/notifications');
            },
          ),
        ),
        Visibility(
          visible: true,
          child: IconButton(
            icon: const Icon(Icons.mail_outline),
            color: Colors.black,
            onPressed: () {
              // Navigate to messages
            },
          ),
        ),
      ],

      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("images/app_logo.png"),
                ),
              ),
            ),

            // Menus
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: const [
                  MenuWidget(maya: "SCRIPT", label: "script"),
                  SizedBox(width: 10),

                  MenuWidget(maya: "LANGUAGE", label: "language"),

                  SizedBox(width: 10),

                  MenuWidget(maya: "DIALECT", label: "dialect"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220);

  void _showAuthenticationDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,

      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),

          clipBehavior: Clip.antiAlias,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.5,

            child: const AuthenticationPage(),
          ),
        );
      },
    );
  }
}
