import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/script/script_content_list_widget.dart';

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
    return BlocSelector<ScriptBloc, BaseState, ({bool fetching, w.Text? text})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          text: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return CircularProgressIndicator();
        }
        if (state.text == null) {
          return Text("no script");
        }
        return ScriptContentListWidget(identifiers: state.text!.contents);
      },
    );
  }
}
