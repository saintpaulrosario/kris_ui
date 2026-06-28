import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/identifier.dart';
import 'content_item_wiget.dart';

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
    return BlocBuilder<WordTextBloc, WordTextState>(
      builder: (context, state) {
        if (state.loading.contains(widget.identifier.sku)) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.errors.containsKey(widget.identifier.sku)) {
          return const Center(child: Text('Failed to load'));
        } else if (state.texts[widget.identifier.sku] == null) {
          return const Center(child: Text('No data available'));
        } else {
          final wordText = state.texts[widget.identifier.sku];

          final contents = wordText!.contents;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              return ContentItemWidget(identifier: contents[index]);
            },
          );
        }
      },
    );
  }
}
