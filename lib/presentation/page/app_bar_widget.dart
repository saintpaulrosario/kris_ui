import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/model/word.dart';

import '../../logic/script/bloc/script_bloc.dart';
import '../../model/script.dart';
import '../widget/menu_widget.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
    context.read<LanguageBloc>().add(LanguageEventFetchAll());
    context.read<DialectBloc>().add(DialectEventFetchAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,

      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          Image.network("https://picsum.photos/800/400", fit: BoxFit.cover),

          Container(color: Colors.black.withValues(alpha: 0.35)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const Text(
                    "ߞߙߌߛߌ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child:
                              BlocSelector<
                                ScriptBloc,
                                ScriptState,
                                ScriptState
                              >(
                                selector: (state) {
                                  return state;
                                },
                                builder: (context, state) {
                                  if (state.data.isEmpty) {
                                    return Text("scripts not availbe");
                                  }

                                  return MenuWidget(
                                    words: state.data.values.toList(),
                                    label: "Script",
                                    onSelect:
                                        ({required select, required word}) {
                                          context.read<ScriptBloc>().add(
                                            ScriptsEventSelected(
                                              selection: word,
                                              select: select,
                                            ),
                                          );
                                        },
                                    selections: state.selections,
                                  );
                                },
                              ),
                        ),

                        const SizedBox(width: 12),

                        SizedBox(
                          width: 150,
                          height: 50,
                          child:
                              BlocSelector<
                                LanguageBloc,
                                LanguageState,
                                LanguageState
                              >(
                                selector: (state) {
                                  return state;
                                },
                                builder: (context, state) {
                                  if (state.data.isEmpty) {
                                    return Text("languages not availbe");
                                  }

                                  return MenuWidget(
                                    words: state.data.values.toList(),
                                    label: "Language",
                                    selections: state.selections,

                                    onSelect:
                                        ({
                                          required word,
                                          required bool select,
                                        }) {
                                          context.read<LanguageBloc>().add(
                                            LanguageEventSelected(
                                              select: select,
                                              selection: word,
                                            ),
                                          );
                                        },
                                  );
                                },
                              ),
                        ),

                        const SizedBox(width: 12),

                        SizedBox(
                          width: 150,
                          height: 50,
                          child:
                              BlocSelector<
                                DialectBloc,
                                DialectState,
                                DialectState
                              >(
                                selector: (state) {
                                  return state;
                                },
                                builder: (context, state) {
                                  if (state.data.isEmpty) {
                                    return Text("dialects not availbe");
                                  }

                                  return MenuWidget(
                                    words: state.data.values.toList(),
                                    label: "Dialect",
                                    onSelect:
                                        ({required select, required word}) {
                                          //context.read<DialectBloc>().add(Dia)
                                        },
                                    selections: {},
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      backgroundColor: Colors.transparent,
      elevation: 4,
      foregroundColor: Colors.white,
    );
  }
}
