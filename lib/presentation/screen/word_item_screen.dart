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
  bool get isExample => widget.identifier.type == 'EXAMPLE';

  @override
  void initState() {
    super.initState();

    if (isExample) {
      context.read<ExampleBloc>().add(
        ExampleEventFetch(identifier: widget.identifier),
      );
    } else {
      context.read<WordBloc>().add(
        RetrieveWordBySkuEvent(identifier: widget.identifier),
      );
    }
  }

  Widget _buildWord({required Word? word, required bool fetching}) {
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
        key: ValueKey(widget.identifier.sku),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ImageListWidget(
                key: ValueKey('${word.sku}_images'),
                imagesIdentifiers: word.images,
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
                  key: ValueKey('${word.sku}_texts'),
                  identifiers: word.texts,
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Center(
                child: Text("${word.ordinal}", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isExample) {
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
          return _buildWord(word: state.word, fetching: state.fetching);
        },
      );
    }

    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),
      builder: (context, state) {
        return _buildWord(word: state.word, fetching: state.fetching);
      },
    );
  }
}
