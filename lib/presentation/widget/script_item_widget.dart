import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word_text.dart';

import '../../model/script.dart';

class ScriptItemWidget extends StatefulWidget {
  final Identifier identifier;
  // script
  // language
  // dialect

  const ScriptItemWidget({super.key, required this.identifier});

  @override
  State<ScriptItemWidget> createState() => _ScriptItemWidgetState();
}

class _ScriptItemWidgetState extends State<ScriptItemWidget> {
  @override
  void initState() {
    context.read<ScriptBloc>().add(
      ScriptEventRetrieveBySku(sku: widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, bool>(
      selector: (scriptState) {
        return scriptState.fetching.contains(widget.identifier.sku);
      },
      builder: (context, scriptState) {
        if (scriptState) {
          return CircularProgressIndicator();
        } else {
          return BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
            selector: (scriptState) {
              return scriptState.scripts;
            },
            builder: (context, scriptState) {
              if (scriptState.isEmpty) {
                return Text("No scripts available");
              } else if (!scriptState.containsKey(widget.identifier.sku)) {
                return Text("script not found");
              } else {
                return BlocSelector<ScriptBloc, ScriptState, Script>(
                  selector: (scriptState) {
                    return scriptState.scripts[widget.identifier.sku]!;
                  },
                  builder: (context, scriptState) {
                    return BlocSelector<
                      WordTextBloc,
                      WordTextState,
                      Map<String, WordText>
                    >(
                      selector: (wordTextState) {
                        return wordTextState.texts;
                      },
                      builder: (context, wordTextState) {
                        if (!wordTextState.containsKey(scriptState.sku)) {
                          return Text(" script Text not found");
                        } else {
                          return Text(wordTextState[scriptState.sku]!.sku);
                        }
                      },
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
