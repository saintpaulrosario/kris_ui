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

import 'language_payload_list_widget.dart';

class LanguageContentWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguageContentWidget({super.key, required this.identifier});

  @override
  State<LanguageContentWidget> createState() => _LanguageContentWidgetState();
}

class _LanguageContentWidgetState extends State<LanguageContentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<LanguageBloc>().add(
      BaseEvent.content(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      Content?
    >(
      selector: (state) {
        return state.contents[widget.identifier.sku];
      },
      builder: (context, content) {
        if (content == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (content.payloads.isEmpty) {
          return const SizedBox.shrink();
        }

        return LanguagePayloadListWidget(identifiers: content.payloads);
      },
    );
  }
}
