import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/payload.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/payload/bloc/payload_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/content.dart';
import '../../model/script.dart';
import '../../model/word_text.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  initState() {
    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
            selector: (state) {
              return state.scripts;
            },
            builder: (context, scriptState) {
              if (scriptState.isEmpty) {
                return Text("No scripts available for selection");
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    scriptState.values.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(scriptState.values.elementAt(index).sku),
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("languages")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("dialects")],
          ),
        ],
      ),
    );
  }
}
