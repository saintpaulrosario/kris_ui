import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/trait.dart';

import 'language_text_list_widget.dart';

class LanguageWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguageWidget({super.key, required this.identifier});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<LanguageBloc>().add(
      BaseEvent.identifier(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      Language?
    >(
      selector: (state) {
        return state.data[widget.identifier.sku];
      },
      builder: (context, language) {
        if (language == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return LanguageTextListWidget(identifiers: language.texts);
      },
    );
  }
}
