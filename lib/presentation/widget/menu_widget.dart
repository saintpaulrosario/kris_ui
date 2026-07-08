import 'package:flutter/material.dart';

import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/menu_content_widget.dart';

class MenuWidget extends StatelessWidget {
  final List<Word> words;
  final Set<String> selectedContents = {};
  final ScrollController _scrollController = ScrollController();
  MenuWidget({super.key, required this.words});

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

                child: ListView.builder(
                  controller: _scrollController,

                  padding: EdgeInsets.zero,

                  itemCount: words.length,

                  itemBuilder: (context, scriptIndex) {
                    final script = words[scriptIndex];

                    return Column(
                      children: [
                        if (scriptIndex > 0) const Divider(),

                        ...script.contents.map((contentIdentifier) {
                          return MenuContentWidget(
                            identifier: contentIdentifier,

                            selected: selectedContents.contains(
                              contentIdentifier.sku,
                            ),

                            onChanged: (value) {},
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
          return InkWell(
            onTap: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },

            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: "Script",

                border: OutlineInputBorder(),

                isDense: true,
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedContents.isEmpty
                          ? "Select"
                          : "${selectedContents.length} selected",

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
