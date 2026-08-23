import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/feature/account/logic/user_account/user_account_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/presentation/menu/dialect_menu.dart';
import 'package:kris/presentation/menu/language_menu.dart';
import 'package:kris/presentation/menu/script_menu.dart';

import '../../app_router.dart';
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
        BlocSelector<UserAccountBloc, UserAccountState, UserAccountState>(
          selector: (state) {
            return state;
          },
          builder: (context, state) {
            return Row(
              children: [
                if (state.authenticated)
                  const Text('john', style: TextStyle(color: Colors.black)),

                Visibility(
                  visible: !state.authenticated,
                  child: IconButton(
                    icon: const Icon(Icons.login),
                    color: Colors.black,
                    onPressed: () {
                      GoRouter.of(context).push(routeAuthentication);
                      // _showAuthenticationDialog(context: context);
                    },
                  ),
                ),

                Visibility(
                  visible: state.authenticated,
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {},
                ),

                Visibility(
                  visible: state.authenticated,
                  child: Badge(
                    label: const Text('4'),
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.mail_outline),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ],
            );
          },
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
                  const LanguageMenu(),
                  const DialectMenu(),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: () {
                        final scripts = context
                            .read<ScriptBloc>()
                            .state
                            .selections
                            .toList();

                        context.read<TranslationBloc>().add(
                          BaseEvent.fetch(scripts: scripts),
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

  void _showAuthenticationDialog({required BuildContext context}) {
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
