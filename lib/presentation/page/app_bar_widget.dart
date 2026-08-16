import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/presentation/menu/script_menu.dart';

import '../../feature/presentation/page/authentication_page.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(220);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,

      actions: [
        const Text('john', style: TextStyle(color: Colors.black)),

        IconButton(
          icon: const Icon(Icons.login),
          color: Colors.black,
          onPressed: () {
            _showAuthenticationDialog(context);
          },
        ),

        IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.black,
          onPressed: () {},
        ),

        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {},
        ),

        Badge(
          label: const Text('4'),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {},
          ),
        ),

        IconButton(
          icon: const Icon(Icons.mail_outline),
          color: Colors.black,
          onPressed: () {},
        ),
      ],

      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.75,
                width: constraints.maxWidth,
                child: Center(
                  child: Image.asset(
                    'images/app_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Menus
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ScriptMenu(),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: () {
                        final selections = context
                            .read<ScriptBloc>()
                            .state
                            .selections
                            .toList();

                        context.read<ScriptBloc>().add(
                          BaseEvent.selects(
                            identifiers: selections,
                            selected: true,
                          ),
                        );
                      },
                      child: const Text('submit'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAuthenticationDialog(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
