import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word_text.dart';
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
        if (state.fetching == true && state.success == false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetching == false && state.success == false) {
          return const Center(child: Text('no word yet available.'));
        } else {
          List<Identifier> contents = state.selection.contents;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              Identifier content = contents[index];
              return ContentItemWidget(identifier: content);
            },
          );
          //return ContentListWidget(contents: state.contents);
        }
      },
    );
  }
}
