import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/text.dart' as w;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: MenuAnchor(
        alignmentOffset: const Offset(0, 5),
        menuChildren: [
          SizedBox(
            width: 320,
            height: MediaQuery.of(context).size.height * .5,
            child: Material(
              elevation: 4,
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.words.length,
                  itemBuilder: (context, index) {
                    final word = widget.words[index];

                    final texts = word.texts.toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index > 0) const Divider(height: 1),

                        ...texts.map(
                          (Identifier identifier) => MenuTextWidget(
                            identifier: identifier,
                            selected: widget.selections.contains(
                              identifier.sku,
                            ),
                            maya: widget.maya,
                            onChanged: (selected) async {
                              if (widget.maya == 'SCRIPT') {
                                context.read<ScriptBloc>().add(
                                  BaseEvent.select(
                                    identifier: identifier,
                                    selected: selected,
                                  ),
                                );
                                context.read<TranslationBloc>().add(
                                  BaseEvent.fetch(
                                    scripts: widget.selections.toSet(),
                                  ),
                                );
                              } else if (widget.maya == 'DIALECT') {
                                context.read<DialectBloc>().add(
                                  BaseEvent.select(
                                    identifier: identifier,
                                    selected: selected,
                                  ),
                                );
                              } else {
                                context.read<LanguageBloc>().add(
                                  BaseEvent.select(
                                    identifier: identifier,
                                    selected: selected,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
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
                labelText: widget.label,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.selections.isEmpty
                          ? 'Select'
                          : '${widget.selections.length} selected',
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
