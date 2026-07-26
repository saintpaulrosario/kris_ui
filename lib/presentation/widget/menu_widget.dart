import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/logic/word/word.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/menu_text_widget.dart';

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

    context.read<WordBloc>().add(
      RetrieveWordsEvent(
        pageNumber: 0,
        pageSize: 10,
        type: 'WORD',
        maya: widget.maya,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      WordState,
      (BuiltSet<Word>, BuiltMap<String, Word>?)
    >(
      selector: (state) => (state.scripts, state.mayaSelections[widget.maya]),
      builder: (context, data) {
        final selections = data.$1;
        final words = data.$2?.values.toList() ?? [];

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
                                selected: selections.contains(word),
                                onChanged: (selected) {
                                  // TODO:
                                  // context.read<WordBloc>().add(
                                  //   SelectWordEvent(
                                  //     word: word,
                                  //     selected: selected,
                                  //   ),
                                  // );
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
      },
    );
  }
}
