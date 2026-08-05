import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app_router.dart';
import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../widget/word_text_list_wiget.dart';

class WordItemScreen extends StatefulWidget {
  final Identifier identifier;

  const WordItemScreen({super.key, required this.identifier});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String get sku => widget.identifier.sku;

  @override
  void initState() {
    super.initState();

    // Bloc decides if it needs to fetch
    context.read<TranslationBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      TranslationBloc,
      TranslationState,
      ({bool fetching, List<Identifier> texts})
    >(
      selector: (state) {
        final word = state.data[sku];

        return (
          fetching: state.fetching.contains(sku),
          texts: word?.texts ?? const [],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.texts.isEmpty) {
          return const Center(child: Text("Word not found"));
        }

        return Card(
          clipBehavior: Clip.antiAlias,

          child: InkWell(
            onTap: () {
              context.pushNamed(routeWordDetail, pathParameters: {'sku': sku});
            },

            child: Padding(
              padding: const EdgeInsets.all(8),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(
                    flex: 4,

                    child: WordTextListWidget(
                      key: ValueKey('${sku}_texts'),
                      identifiers: state.texts,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
