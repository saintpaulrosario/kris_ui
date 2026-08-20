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

import 'language_content_widget.dart';

class LanguageTextWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguageTextWidget({super.key, required this.identifier});

  @override
  State<LanguageTextWidget> createState() => _LanguageTextWidgetState();
}

class _LanguageTextWidgetState extends State<LanguageTextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<LanguageBloc>().add(
      BaseEvent.text(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      w.Text?
    >(
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (text.contents.isEmpty) {
          return const SizedBox.shrink();
        }

        return LanguageContentWidget(identifier: text.contents.first);
      },
    );
  }
}
