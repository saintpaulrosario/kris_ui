import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word_text.dart';
import 'menu_list_wiget.dart';
import 'menu_widget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;

  const WordTextItemWidget({super.key, required this.identifier});

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    context.read<WordTextBloc>().add(
      WordTextEventRetrieveBySku(sku: widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordTextBloc, WordTextState, bool>(
      selector: (state) => state.fetching.contains(widget.identifier.sku),
      builder: (context, fetching) {
        if (fetching) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return BlocSelector<
            WordTextBloc,
            WordTextState,
            Map<String, WordText>
          >(
            selector: (state) {
              return state.data;
            },
            builder: (context, state) {
              if (state.isEmpty) {
                return Text('No text available');
              } else if (!state.containsKey(widget.identifier.sku)) {
                return Text('Text not available for this SKU');
              } else {
                return BlocSelector<WordTextBloc, WordTextState, WordText>(
                  selector: (state) {
                    return state.data[widget.identifier.sku]!;
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        ScriptItemWidget(identifier: state.script!),
                        ContentListWidget(identifiers: state.contents),
                      ],
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
