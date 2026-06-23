import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';

import '../../model/identifier.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier textIdentifier;

  const WordTextItemWidget({super.key, required this.textIdentifier});

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ContentBloc>().add(
      ContentEventRetriveByTextSku(widget.textIdentifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }
        // if (!state.success) {
        //   return const Center(child: Text('Failed to load text content.'));
        // }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.contents.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            //final contentsIdentifiers = state.text.contents;
            return ContentListWidget(contents: state.contents);
          },
        );
      },
    );
  }
}
