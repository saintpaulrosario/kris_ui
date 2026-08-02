import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../app_router.dart';
import '../../logic/base_event.dart';
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
    context.read<TranslationBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      TranslationState,
      ({bool fetching, Translation? word})
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
                  flex: 4,
                  child: InkWell(
                    onTap: () {
                      context.pushReplacementNamed(
                        routePayloadDetail,
                        pathParameters: {'sku': widget.identifier.sku},
                      );
                    },
                    child: WordTextListWidget(
                      key: ValueKey('${state.word!.sku}_texts'),
                      identifiers: state.word!.texts,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
