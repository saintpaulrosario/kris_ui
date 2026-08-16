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
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );

    // context.read<LanguageBloc>().add(
    //   BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    // );

    // context.read<DialectBloc>().add(
    //   BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    // );
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);

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
          onPressed: () {
            // TODO logout
          },
        ),

        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            // TODO search
          },
        ),

        Badge(
          label: const Text('4'),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {
              // TODO notifications
            },
          ),
        ),

        IconButton(
          icon: const Icon(Icons.mail_outline),
          color: Colors.black,
          onPressed: () {
            // TODO messages
          },
        ),
      ],

      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // -------------------------------------------------
              // LOGO
              // -------------------------------------------------
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

              // -------------------------------------------------
              // MENUS
              // -------------------------------------------------
              BlocSelector<
                ScriptBloc,
                BaseState<Script, w.Text, Content, Payload>,
                BaseState<Script, w.Text, Content, Payload>
              >(
                selector: (state) => state,
                builder: (context, script) {
                  return BlocSelector<
                    LanguageBloc,
                    BaseState<Language, w.Text, Content, Payload>,
                    BaseState<Language, w.Text, Content, Payload>
                  >(
                    selector: (state) => state,
                    builder: (context, language) {
                      return BlocSelector<
                        DialectBloc,
                        BaseState<Dialect, w.Text, Content, Payload>,
                        BaseState<Dialect, w.Text, Content, Payload>
                      >(
                        selector: (state) => state,
                        builder: (context, dialect) {
                          return Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    MenuWidget(
                                      maya: 'SCRIPT',
                                      label: 'script',
                                      words: script.data.values.toList(),
                                      selections: script.selections.toSet(),
                                    ),

                                    // const SizedBox(width: 10),

                                    // MenuWidget(
                                    //   maya: 'LANGUAGE',
                                    //   label: 'language',
                                    //   words: language.data.values.toList(),
                                    //   selections: language.selections.toSet(),
                                    // ),
                                    // const SizedBox(width: 10),

                                    // MenuWidget(
                                    //   maya: 'DIALECT',
                                    //   label: 'dialect',
                                    //   words: dialect.data.values.toList(),
                                    //   selections: dialect.selections.toSet(),
                                    // ),
                                    //const SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Submit
                                        },
                                        child: const Text('submit'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
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
