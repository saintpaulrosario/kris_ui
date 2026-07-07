import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'menu_item_text_list_item_widget.dart';

class MenuItemTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const MenuItemTextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: identifiers
          .map(
            (identifier) => MenuItemTextListItemWidget(identifier: identifier),
          )
          .toList(),
    );
  }
}
