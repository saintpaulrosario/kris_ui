import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/language.dart';

import 'language/language_list_widget.dart';
import 'payload_list_widget.dart';

class ContentWidget extends StatelessWidget {
  final Content content;

  const ContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: PayloadListWidget(
            key: ValueKey(content.sku),
            identifiers: content.payloads,
          ),
        ),
        Expanded(
          child: LanguageListWidget(
            key: ValueKey(content.sku),
            identifiers: content.languages,
          ),
        ),
      ],
    );
  }
}
