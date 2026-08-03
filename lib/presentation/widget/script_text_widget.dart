import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/script_wiget.dart';

import '../../logic/base_event.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../model/identifier.dart';
import '../../model/script_text.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';
import 'script_content_list_widget.dart';

class ScriptTextWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptTextWidget({super.key, required this.identifier});

  @override
  State<ScriptTextWidget> createState() => _ScriptTextWidgetState();
}

class _ScriptTextWidgetState extends State<ScriptTextWidget> {
  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      ScriptState,
      ({bool fetching, ScriptText? text})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        text: state.texts[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.text == null) {
          return const Text("Text not found");
        }

        if (state.text!.contents.isEmpty) {
          return const Text("No content found");
        }

        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ScriptContentListWidget(
                    identifiers: state.text!.contents,
                    key: ValueKey(state.text!.sku),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
