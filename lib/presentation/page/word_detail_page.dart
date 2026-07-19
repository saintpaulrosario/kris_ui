import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/bloc/word_bloc.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

import '../widget/example_item_widget.dart';

class WordDetailPage extends StatelessWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WordItemScreen(identifier: identifier),
        BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
          selector: (state) {
            return (
              fetching: state.fetching.contains(identifier.sku),
              word: state.data[identifier.sku],
            );
          },
          builder: (context, state) {
            if (state.fetching) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.word == null) {
              return const Center(child: Text("Word not found"));
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.word!.examples.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return WordItemScreen(
                  identifier: state.word!.examples.elementAt(index),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
