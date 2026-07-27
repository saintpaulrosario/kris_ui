import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/logic/content/content.dart';
import 'package:kris/logic/identifier.dart';

import 'package:kris/logic/word/word.dart';
import 'package:kris/presentation/widget/menu_content_widget.dart';

class MenuWidget extends StatelessWidget {
  final List<Word> words;
  final BuiltSet<Word> selections;
  final ScrollController _scrollController = ScrollController();
  final String label;
  final Function({required Word word, required bool select}) onSelect;
  MenuWidget({
    super.key,
    required this.words,
    required this.label,
    required this.onSelect,
    required this.selections,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,

      child: MenuAnchor(
        alignmentOffset: const Offset(0, 5),

        menuChildren: [
          SizedBox(
            width: 300,

            height: MediaQuery.of(context).size.height * 0.5,

            child: Material(
              elevation: 4,

              child: Scrollbar(
                controller: _scrollController,

                thumbVisibility: true,

                child: BlocSelector<WordBloc, WordState, BuiltSet<Word>>(
                  selector: (state) {
                    return state.selections;
                  },
                  builder: (context, scriptState) {
                    return ListView.builder(
                      controller: _scrollController,

                      padding: EdgeInsets.zero,

                      itemCount: words.length,

                      itemBuilder: (context, scriptIndex) {
                        final word = words[scriptIndex];

                        Set<int> allowedScripts = scriptState
                            .map((item) => item.ordinal)
                            .toSet();

                        Set<Identifier> filteredContents = word.contents
                            .toSet();

                        if (scriptState.isNotEmpty) {
                          for (Identifier identifier in word.contents) {
                            if (!allowedScripts.contains(identifier.ordinal)) {
                              filteredContents.remove(identifier);
                            }
                          }
                        }

                        // filter the scripts

                        return Column(
                          children: [
                            if (scriptIndex > 0) const Divider(),

                            ...word.contents.map((identifier) {
                              return MenuContentWidget(
                                identifier: identifier,

                                selected: selections.contains(word),

                                onChanged: (value) {
                                  onSelect(word: word, select: value);
                                },
                              );
                            }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],

        builder: (context, controller, child) {
          return InkWell(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },

            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,

                border: OutlineInputBorder(),

                isDense: true,
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selections.isEmpty
                          ? "Select"
                          : "${selections.length} selected",

                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Icon(
                    controller.isOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
