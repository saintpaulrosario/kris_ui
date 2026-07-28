import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/logic/word/word.dart';

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
    super.initState();

    final bloc = context.read<WordBloc>();

    bloc.add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'SCRIPT',
      ),
    );

    bloc.add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'LANGUAGE',
      ),
    );

    bloc.add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: 'DIALECT',
      ),
    );
  }

  Widget buildMenu({required String type, required BuiltSet<Word> words}) {
    return SizedBox(
      width: 150,
      height: 50,

      child: BlocSelector<WordBloc, WordState, BuiltMap<String, Word>>(
        selector: (state) {
          return state.mayaSelections[type] ?? BuiltMap<String, Word>();
        },

        builder: (context, selections) {
          if (words.isEmpty) {
            return Text(
              "$type not available",
              style: const TextStyle(color: Colors.white),
            );
          }

          return MenuWidget(
            words: words.toList(),

            label: type,

            selections: selections.values.toBuiltSet(),

            onSelect: ({required Word word, required bool select}) {
              // TODO:
              // dispatch selection event here
            },
          );
        },
      ),
    );
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

                  BlocSelector<
                    WordBloc,
                    WordState,
                    (BuiltSet<Word>, BuiltSet<Word>, BuiltSet<Word>)
                  >(
                    selector: (state) {
                      return (state.scripts, state.languages, state.dialects);
                    },

                    builder: (context, state) {
                      final scripts = state.$1;

                      final languages = state.$2;

                      final dialects = state.$3;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          children: [
                            buildMenu(type: "SCRIPT", words: scripts),

                            const SizedBox(width: 12),

                            buildMenu(type: "LANGUAGE", words: languages),

                            const SizedBox(width: 12),

                            buildMenu(type: "DIALECT", words: dialects),
                          ],
                        ),
                      );
                    },
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
