import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/menu_item_widget.dart';
import 'package:kris/presentation/widget/menu_list_wiget.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/payload/bloc/payload_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/content.dart';
import '../../model/script.dart';
import '../../model/word.dart';
import '../../model/word_text.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
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
            builder: (context, state) {
              if (state.isEmpty) {
                return Text("No scripts available for selection");
              }
              List<Script> scripts = state.values.toList();
              return MenuListWiget(
                words: scripts,
                onPress: ({required Word word, required bool select}) {
                  context.read<ScriptBloc>().add(
                    ScriptsEventSelected(selection: word, select: select),
                  );
                },
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

  onPress() {}
}
