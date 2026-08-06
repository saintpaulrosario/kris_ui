import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';

import 'menu_text_widget.dart';

class MenuWidget extends StatefulWidget {
  final String maya;
  final String label;

  const MenuWidget({super.key, required this.maya, required this.label});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if ("SCRIPT" == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.fetch(pageNumber: 0, pageSize: 10),
      );
    } else if ("LANGUAGE" == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.fetch(pageNumber: 0, pageSize: 10),
      );
    } else {
      context.read<DialectBloc>().add(
        BaseEvent.fetch(pageNumber: 0, pageSize: 10),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maya == 'LANGUAGE') {
      return BlocSelector<
        LanguageBloc,
        LanguageState,
        (BuiltSet<String>, BuiltMap<String, Language>?)
      >(
        selector: (state) => (state.selections, state.data),
        builder: (context, data) {
          final selections = data.$1;
          final words = data.$2?.values.toList() ?? [];

          return _buildMenu(
            scrollController: _scrollController,
            words: words,
            selections: selections,
            widget: widget,
            maya: 'LANGUAGE',
          );
        },
      );
    }

    if (widget.maya == 'DIALECT') {
      return BlocSelector<
        DialectBloc,
        DialectState,
        (BuiltSet<String>, BuiltMap<String, Dialect>?)
      >(
        selector: (state) => (state.selections, state.data),
        builder: (context, data) {
          final selections = data.$1;
          final words = data.$2?.values.toList() ?? [];

          return _buildMenu(
            scrollController: _scrollController,
            words: words,
            selections: selections,
            widget: widget,
            maya: 'DIALECT',
          );
        },
      );
    }
    return BlocSelector<
      ScriptBloc,
      ScriptState,
      (BuiltSet<String>, BuiltMap<String, Script>?)
    >(
      selector: (state) => (state.selections, state.data),
      builder: (context, data) {
        final selections = data.$1;
        final words = data.$2?.values.toList() ?? [];

        return _buildMenu(
          scrollController: _scrollController,
          words: words,
          selections: selections,
          widget: widget,
          maya: 'SCRIPT',
        );
      },
    );
  }
}

class _buildMenu extends StatelessWidget {
  const _buildMenu({
    super.key,
    required this._scrollController,
    required this.words,
    required this.selections,
    required this.widget,
    required this.maya,
  });

  final ScrollController _scrollController;
  final List<Word> words;
  final BuiltSet<String> selections;
  final MenuWidget widget;
  final String maya;

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
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    final word = words[index];

                    final texts = word.texts.toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index > 0) const Divider(height: 1),

                        ...texts.map(
                          (Identifier identifier) => MenuTextWidget(
                            identifier: identifier,
                            selected: selections.contains(identifier.sku),
                            maya: widget.maya,
                            onChanged: (selected) {
                              if (maya == 'SCRIPT') {
                                context.read<ScriptBloc>().add(
                                  BaseEvent.select(
                                    identifier: identifier,
                                    selected: selected,
                                  ),
                                );
                              } else if (maya == 'DIALECT') {
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
                      selections.isEmpty
                          ? 'Select'
                          : '${selections.length} selected',
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
