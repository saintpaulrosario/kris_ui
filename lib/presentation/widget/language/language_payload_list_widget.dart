import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/language/language_payload_widget.dart';

import '../../../model/identifier.dart';

class LanguagePayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguagePayloadListWidget({super.key, required this.identifiers});

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
            return LanguagePayloadWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
