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
        if (state.fetching == true && state.success == false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetching == false && state.success == false) {
          return const Center(child: Text('no word yet available.'));
        } else {
          return ContentListWidget(contents: state.contents);
        }
      },
    );
  }
}
