import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../app_router.dart';
import '../../logic/base_event.dart';
import '../../model/script.dart';
import '../widget/image_list_widget.dart';
import 'script_text_list_widget.dart';

class ScriptWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptWidget({super.key, required this.identifier});

  @override
  State<ScriptWidget> createState() => _ScriptWidgetState();
}

class _ScriptWidgetState extends State<ScriptWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ScriptBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      ScriptState,
      ({bool fetching, Script? word})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.word == null) {
          return const Center(child: Text("script not found"));
        }

        return Card(
          key: ValueKey(widget.identifier.sku),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ScriptTextListWidget(
                  key: ValueKey('${state.word!.sku}_texts'),
                  identifiers: state.word!.texts,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
