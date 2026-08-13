import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kris/presentation/widget/language/language_text_widget.dart';

import '../../../model/identifier.dart';

class LanguageTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguageTextListWidget({super.key, required this.identifiers});

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
            return LanguageTextWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
