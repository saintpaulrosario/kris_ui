import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/menu_payload_list_widget.dart';

class MenuContentItemWidget extends StatefulWidget {
  final Identifier identifier;
  const MenuContentItemWidget({super.key, required this.identifier});

  @override
  State<MenuContentItemWidget> createState() => _MenuContentItemWidgetState();
}

class _MenuContentItemWidgetState extends State<MenuContentItemWidget> {
  @override
  void initState() {
    context.read<ContentBloc>().add(
      ContentEventRetriveBySku(widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ContentBloc, ContentState, Map<String, Content>>(
      selector: (state) {
        return state.contents;
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return Text("no contents");
        } else if (!state.containsKey(widget.identifier.sku)) {
          return Text("content not contained");
        }
        return BlocSelector<ContentBloc, ContentState, Content?>(
          selector: (state) {
            return state.contents[widget.identifier.sku];
          },
          builder: (context, state) {
            List<Identifier> identifiers = state!.payloads;
            return MenuPayloadListWidget(identifiers: identifiers);
          },
        );
      },
    );
  }
}
