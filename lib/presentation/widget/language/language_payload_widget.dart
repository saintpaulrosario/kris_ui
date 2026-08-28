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
import 'package:kris/presentation/widget/audio_list_wiget.dart';
import 'package:kris/presentation/widget/language/language_trait_list_widget.dart';

class LanguagePayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguagePayloadWidget({super.key, required this.identifier});

  @override
  State<LanguagePayloadWidget> createState() => _LanguagePayloadWidgetState();
}

class _LanguagePayloadWidgetState extends State<LanguagePayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<LanguageBloc>().add(
      BaseEvent.payload(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      Payload?
    >(
      selector: (state) {
        return state.payloads[widget.identifier.sku];
      },
      builder: (context, payload) {
        if (payload == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Row(
          children: [
            LanguageTraitListWidget(identifiers: payload.traits),
            Text(
              payload.value,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              key: ValueKey(payload.sku),
            ),
          ],
        );
      },
    );
  }
}
