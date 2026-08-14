import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/dialect/dialect_content_widget.dart';
import 'package:kris/presentation/widget/dialect/dialect_payload_list_widget.dart';
import 'package:kris/presentation/widget/language/language_content_widget.dart';

import '../../../model/identifier.dart';

class DialectContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const DialectContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: identifiers.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final identifier = identifiers.elementAt(index);
            return DialectContentWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
