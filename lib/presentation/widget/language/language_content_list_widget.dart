import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/language/language_content_widget.dart';

import '../../../model/identifier.dart';

class LanguageContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const LanguageContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: identifiers.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final identifier = identifiers.elementAt(index);
            return LanguageContentWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
