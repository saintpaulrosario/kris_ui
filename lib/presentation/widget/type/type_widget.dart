import 'package:flutter/material.dart';
import 'package:kris/model/type.dart' as w;
import 'package:kris/presentation/widget/type/type_text_list_widget.dart';




class TypeWidget extends StatelessWidget {
  final w.Type type;
  const TypeWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return TypeTextListWidget(
      key: ValueKey('${type.sku}-texts'),
      identifiers: type.texts,
    );
  }
}
