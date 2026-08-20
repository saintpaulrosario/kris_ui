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

import '../../model/trait.dart';
import 'language/language_list_widget.dart';
import 'payload_list_widget.dart';

class TraitWidget extends StatelessWidget {
  final Trait trait;

  const TraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(trait.sku)),
        // Expanded(
        //   child: LanguageListWidget(
        //     key: ValueKey(trait.sku),
        //     identifiers: trait.languages,
        //   ),
        // ),
      ],
    );
  }
}
