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
                                Map<String, Script>
                              >(
                                selector: (state) {
                                  return state.scripts;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return Text("scripts not availbe");
                                  }
                                  List<Word> words = state.values.toList();
                                  return MenuWidget(words: words);
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
                                Map<String, Language>
                              >(
                                selector: (state) {
                                  return state.languages;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return Text("languages not availbe");
                                  }
                                  List<Word> words = state.values.toList();
                                  return MenuWidget(words: words);
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
                                Map<String, Dialect>
                              >(
                                selector: (state) {
                                  return state.dialects;
                                },
                                builder: (context, state) {
                                  if (state.isEmpty) {
                                    return Text("dialects not availbe");
                                  }
                                  List<Word> words = state.values.toList();
                                  return MenuWidget(words: words);
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
