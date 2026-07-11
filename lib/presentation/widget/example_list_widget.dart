import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/example_item_widget.dart';

class ExampleListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  const ExampleListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: identifiers.length,

      separatorBuilder: (_, __) {
        return Divider();
      },
      itemBuilder: (context, index) {
        return ExampleItemWidget(identifier: identifiers.elementAt(index));
      },
    );
  }
}
