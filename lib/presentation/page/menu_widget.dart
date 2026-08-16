import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';

import 'menu_text_widget.dart';

class MenuWidget extends StatefulWidget {
  final String maya;
  final String label;
  final List<Word> words;
  final Set<Identifier> selections;

  final void Function(Identifier identifier, bool selected) onSelectionChanged;

  const MenuWidget({
    super.key,
    required this.maya,
    required this.label,
    required this.words,
    required this.selections,
    required this.onSelectionChanged,
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
          height: MediaQuery.sizeOf(context).height * 0.5,
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

                  final wordIdentifier = Identifier(
                    sku: word.sku,
                    ordinal: word.ordinal,
                    createdDate: word.createdDate,
                    lastModifiedDate: word.lastModifiedDate,
                    createdBy: word.createdBy,
                    lastModifiedBy: word.lastModifiedBy,
                    version: word.version,
                  );

                  final texts = word.texts.toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index > 0) const Divider(height: 1, thickness: 1),

                      ...texts.map((identifier) {
                        return MenuTextWidget(
                          identifier: identifier,

                          // Selection belongs to the WORD
                          selected: widget.selections.contains(wordIdentifier),

                          maya: widget.maya,

                          onChanged: (selected) {
                            // Send the WORD identifier
                            widget.onSelectionChanged(wordIdentifier, selected);
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
