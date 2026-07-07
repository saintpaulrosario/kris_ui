import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word_text.dart';
import 'package:kris/presentation/widget/menu_content_list_widget.dart';

class MenuItemTextListItemWidget extends StatefulWidget {
  final Identifier identifier;

  const MenuItemTextListItemWidget({super.key, required this.identifier});

  @override
  State<MenuItemTextListItemWidget> createState() =>
      _MenuItemTextListItemWidgetState();
}

class _MenuItemTextListItemWidgetState
    extends State<MenuItemTextListItemWidget> {
  @override
  void initState() {
    context.read<WordTextBloc>().add(
      WordTextEventRetrieveBySku(sku: widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordTextBloc, WordTextState, WordText>(
      selector: (state) {
        return state.texts[widget.identifier.sku]!;
      },
      builder: (context, state) {
        List<Identifier> identifiers = state.contents;
        return MenuContentListWidget(identifiers: identifiers);
      },
    );
  }
}
