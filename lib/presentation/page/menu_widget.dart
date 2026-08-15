import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';

import '../../logic/word/dialect_bloc.dart';
import '../../logic/word/language_bloc.dart';
import '../../logic/word/script_bloc.dart';
import 'menu_text_widget.dart';

class MenuWidget extends StatefulWidget {
  final String maya;
  final String label;
  final List<Word> words;
  final Set<String> selections;

  const MenuWidget({
    super.key,
    required this.maya,
    required this.label,
    required this.words,
    required this.selections,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: const Offset(0, 5),

      menuChildren: [
        SizedBox(
          width: 320,
          height: MediaQuery.of(context).size.height * .5,
          child: Material(
            elevation: 4,
            color: Colors.white,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: widget.words.length,
                itemBuilder: (context, index) {
                  final word = widget.words[index];

                  final texts = word.texts.toList();

                  final Identifier wordIdentifier = Identifier(
                    sku: word.sku,
                    ordinal: word.ordinal,
                    createdDate: word.createdDate,
                    lastModifiedDate: word.lastModifiedDate,
                    createdBy: word.createdBy,
                    lastModifiedBy: word.lastModifiedBy,
                    version: word.version,
                  );
                  // todo send word as selected
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0) const Divider(height: 1, thickness: 1),

                      ...texts.map((Identifier identifier) {
                        return MenuTextWidget(
                          identifier: identifier,
                          selected: widget.selections.contains(
                            wordIdentifier.sku,
                          ),
                          maya: widget.maya,
                          onChanged: (selected) {
                            if (widget.maya == 'SCRIPT') {
                              context.read<ScriptBloc>().add(
                                BaseEvent.select(
                                  identifier: wordIdentifier,
                                  selected: selected,
                                ),
                              );
                            } else if (widget.maya == 'DIALECT') {
                              context.read<DialectBloc>().add(
                                BaseEvent.select(
                                  identifier: wordIdentifier,
                                  selected: selected,
                                ),
                              );
                            } else {
                              context.read<LanguageBloc>().add(
                                BaseEvent.select(
                                  identifier: wordIdentifier,
                                  selected: selected,
                                ),
                              );
                            }
                          },
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],

      builder: (context, controller, child) {
        return SizedBox(
          width: 180,
          height: 48,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),

                  Icon(
                    controller.isOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
