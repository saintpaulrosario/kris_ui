import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/script.dart';

import '../../feature/presentation/page/authentication_page.dart';
import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/word/dialect_bloc.dart';
import '../../logic/word/language_bloc.dart';
import '../../logic/word/script_bloc.dart';
import '../../model/content.dart';
import '../../model/dialect.dart';
import '../../model/language.dart';
import '../../model/payload.dart';
import '../../model/text.dart' as w;
import 'menu_widget.dart';

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
    context.read<ScriptBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 10),
    );

    context.read<LanguageBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 10),
    );

    context.read<DialectBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
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
                    width: size.width * 0,
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

      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              SizedBox(
                height: constraints.maxHeight * 0.75,
                width: constraints.maxWidth,
                child: Center(
                  child: Image.asset(
                    "images/app_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Menus
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child:
                    BlocSelector<
                      ScriptBloc,
                      BaseState<Script, w.Text, Content, Payload>,
                      BaseState<Script, w.Text, Content, Payload>
                    >(
                      selector: (state) {
                        return state;
                      },
                      builder: (context, script) {
                        return BlocSelector<
                          LanguageBloc,
                          BaseState<Language, w.Text, Content, Payload>,
                          BaseState<Language, w.Text, Content, Payload>
                        >(
                          selector: (state) {
                            return state;
                          },
                          builder: (context, language) {
                            return BlocSelector<
                              DialectBloc,
                              BaseState<Dialect, w.Text, Content, Payload>,
                              BaseState<Dialect, w.Text, Content, Payload>
                            >(
                              selector: (state) {
                                return state;
                              },
                              builder: (context, dialect) {
                                return Row(
                                  children: [
                                    MenuWidget(
                                      maya: "SCRIPT",
                                      label: "script",
                                      words: script.data.values.toList(),
                                      selections: script.selections.toSet(),
                                    ),
                                    const SizedBox(width: 10),

                                    MenuWidget(
                                      maya: "LANGUAGE",
                                      label: "language",
                                      words: language.data.values.toList(),
                                      selections: language.selections.toSet(),
                                    ),

                                    const SizedBox(width: 10),

                                    MenuWidget(
                                      maya: "DIALECT",
                                      label: "dialect",
                                      words: dialect.data.values.toList(),
                                      selections: dialect.selections.toSet(),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // context.read<TranslationBloc>().add(
                                          //   BaseEvent.fetch(
                                          //     scripts: script.selections
                                          //         .toSet(),
                                          //     languages: language.selections
                                          //         .toSet(),
                                          //     dialects: dialect.selections
                                          //         .toSet(),
                                          //   ),
                                          // );
                                        },
                                        child: const Text("submit"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          );
        },
      ),
    );
  }

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
