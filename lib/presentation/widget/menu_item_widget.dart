import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/word_text.dart';
import 'package:kris/presentation/widget/menu_item_text_list_widget.dart';

class ScriptMenuItemWidget extends StatelessWidget {
  final Word word;
  const ScriptMenuItemWidget({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, Map<String, Word>>(
      selector: (state) {
        return state.words;
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return Text("words not available");
        } else if (!state.containsKey(word.sku)) {
          return Text("word not available");
        }

        return BlocSelector<WordBloc, WordState, Word?>(
          selector: (state) {
            return state.words[word.sku];
          },
          builder: (context, state) {
            List<Identifier> identifiers = state!.texts;
            return MenuItemTextListWidget(identifiers: identifiers);
          },
        );
      },
    );
  }
}
