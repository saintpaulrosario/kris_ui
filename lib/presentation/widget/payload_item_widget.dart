import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';
import 'package:kris/presentation/widget/word_widget.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';

class PayloadItemWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;
  final Set<String> visited;

  const PayloadItemWidget({
    super.key,
    required this.identifier,
    required this.maya,
    required this.visited,
  });

  @override
  State<PayloadItemWidget> createState() => _PayloadItemWidgetState();
}

class _PayloadItemWidgetState extends State<PayloadItemWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    if ("DIALECT" == widget.maya) {
      context.read<DialectBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool dialectVisited = widget.visited.contains(widget.identifier.sku);
    final Set<String> nextVisited = {...widget.visited, widget.identifier.sku};
    return BlocSelector<
      TranslationBloc,
      BaseState<
        Translation,
        TranslationText,
        TranslationContent,
        TranslationPayload
      >,
      ({bool fetching, TranslationPayload? payload})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        payload: state.payloads[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.payload == null) {
          return const Text("Payload was not fetched");
        }

        return Row(
          children: [
            dialectVisited
                ? SizedBox.shrink()
                : Expanded(
                    child: SoundListWidget(identifiers: state.payload!.sounds),
                  ),

            // dialectVisited
            //     ? SizedBox.shrink()
            //     : ListView.builder(
            //         shrinkWrap: true,
            //         itemBuilder: (BuildContext context, int index) {
            //           final identifier = state.payload!.dialects.elementAt(
            //             index,
            //           );
            //           Expanded(
            //             child: WordWidget(
            //               identifier: identifier,
            //               maya: 'DIALECT',
            //               visited: nextVisited,
            //             ),
            //           );
            //         },
            //       ),
            Expanded(
              child: Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                key: ValueKey('${state.payload!.sku}_${widget.maya}'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
