import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../model/identifier.dart';
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
      ({bool fetching, List<Identifier> texts})
    >(
      selector: (state) {
        final script = state.data[widget.identifier.sku];

        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          texts: script?.texts ?? [],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.texts.isEmpty) {
          return const Center(child: Text("script not found"));
        }

        return Card(
          child: Flexible(
            child: ScriptTextListWidget(identifiers: state.texts),
          ),
        );
      },
    );
  }
}
