import 'package:flutter/material.dart';

import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/content_list_widget.dart';

class TypeTextWidget extends StatelessWidget {
  final w.Text text;

  const TypeTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ContentListWidget(identifiers: text.contents);
  }
}
