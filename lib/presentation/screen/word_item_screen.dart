import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kris/logic/example/bloc/example_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';
import 'package:kris/logic/identifier.dart';
import 'package:kris/logic/word/word.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../app_router.dart';
import '../widget/image_list_widget.dart';

class WordItemScreen extends StatefulWidget {
  final Identifier identifier;

  const WordItemScreen({super.key, required this.identifier});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.identifier.type == 'EXAMPLE') {
      context.read<ExampleBloc>().add(
        ExampleEventFetch(identifier: widget.identifier),
      );
    } else {
      context.read<WordBloc>().add(
        RetrieveWordBySkuEvent(identifier: widget.identifier),
      );
    }
  }

  Widget _buildWord(Word? word, bool fetching) {
    if (fetching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (word == null) {
      return const Center(child: Text("Word not found"));
    }

    return InkWell(
      onTap: () {
        context.pushReplacementNamed(
          routeWordDetail,
          pathParameters: {'sku': widget.identifier.sku},
        );
      },
      child: Card(
        key: Key(widget.identifier.sku),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageListWidget(
                    key: Key(word.sku),
                    imagesIdentifiers: word.images,
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {
                  context.pushReplacementNamed(
                    routePayloadDetail,
                    pathParameters: {'sku': widget.identifier.sku},
                  );
                },
                child: WordTextListWidget(
                  identifiers: word.texts,
                  key: Key(word.sku),
                ),
              ),
            ),

            Expanded(flex: 1, child: Text("${word.ordinal}")),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifier.type == 'EXAMPLE') {
      return BlocSelector<
        ExampleBloc,
        ExampleState,
        ({bool fetching, Word? word})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          word: state.data[widget.identifier.sku],
        ),

        builder: (context, state) {
          return _buildWord(state.word, state.fetching);
        },
      );
    }

    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),

      builder: (context, state) {
        return _buildWord(state.word, state.fetching);
      },
    );
  }
}
