import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/menu_content_item_widget.dart';

class MenuContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const MenuContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: identifiers
          .map((identifier) => MenuContentItemWidget(identifier: identifier))
          .toList(),
    );
  }
}
