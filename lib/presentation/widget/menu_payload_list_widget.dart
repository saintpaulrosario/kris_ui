import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/menu_payload_item_widget.dart';

import 'menu_item_text_list_item_widget.dart';

class MenuPayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const MenuPayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: identifiers
          .map((identifier) => MenuPayloadItemWidget(identifier: identifier))
          .toList(),
    );
  }
}
