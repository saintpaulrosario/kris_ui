import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word_text.dart';

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
      builder: (context, loading) {
        if (loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return BlocSelector<WordTextBloc, WordTextState, WordText?>(
            selector: (state) {
              return state.texts[widget.identifier.sku];
            },
            builder: (context, state) {
              if (state == null) {
                return const Center(child: Text("No content available"));
              }
              return ContentListWidget(identifiers: state.contents);
            },
          );
        }
      },
    );
  }
}
