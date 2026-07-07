import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/presentation/widget/menu_list_wiget.dart';

import '../../logic/script/bloc/script_bloc.dart';
import '../../model/script.dart';
import '../../model/word.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  initState() {
    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
    context.read<LanguageBloc>().add(LanguageEventFetchAll());
    context.read<DialectBloc>().add(DialectEventFetchAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
                selector: (state) {
                  return state.scripts;
                },
                builder: (context, state) {
                  if (state.isEmpty) {
                    return Text("No scripts available for selection");
                  }
                  List<Script> scripts = state.values.toList();
                  return MenuListWiget(
                    hint: "select a script",
                    label: "script",
                    words: scripts,
                    onPress: ({required Word word, required bool select}) {
                      context.read<ScriptBloc>().add(
                        ScriptsEventSelected(selection: word, select: select),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          // language
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BlocSelector<LanguageBloc, LanguageState, Map<String, Language>>(
                selector: (state) {
                  return state.languages;
                },
                builder: (context, state) {
                  if (state.isEmpty) {
                    return Text("No language available for selection");
                  }
                  List<Language> scripts = state.values.toList();
                  return MenuListWiget(
                    hint: "select a langauge",
                    label: "langauge",
                    words: scripts,
                    onPress: ({required Word word, required bool select}) {
                      context.read<LanguageBloc>().add(
                        LanguageEventSelected(selection: word, select: select),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              BlocSelector<DialectBloc, DialectState, DialectState>(
                selector: (state) {
                  return state;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          BlocSelector<
                            DialectBloc,
                            DialectState,
                            Map<String, Dialect>
                          >(
                            selector: (state) {
                              return state.dialects;
                            },
                            builder: (context, state) {
                              if (state.isEmpty) {
                                return Text(
                                  "No dialect available for selection",
                                );
                              }
                              List<Dialect> scripts = state.values.toList();
                              return MenuListWiget(
                                hint: "select a dialect",
                                label: "dialect",
                                words: scripts,
                                onPress:
                                    ({
                                      required Word word,
                                      required bool select,
                                    }) {
                                      context.read<LanguageBloc>().add(
                                        LanguageEventSelected(
                                          selection: word,
                                          select: select,
                                        ),
                                      );
                                    },
                              );
                            },
                          ),

                          //state.selections.map(e->) Text(e.sku);
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
