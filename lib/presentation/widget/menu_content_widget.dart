import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../model/content.dart';
import '../../model/identifier.dart';
import 'menu_payload_widget.dart';

class MenuContentWidget extends StatefulWidget {
  final Identifier identifier;

  final bool selected;

  final Function(bool) onChanged;

  const MenuContentWidget({
    super.key,
    required this.identifier,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<MenuContentWidget> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContentWidget> {
  @override
  void initState() {
    super.initState();

    context.read<ContentBloc>().add(
      ContentEventRetriveBySku(widget.identifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ContentBloc, ContentState, Content?>(
      selector: (state) => state.data[widget.identifier.sku],

      builder: (context, content) {
        if (content == null) {
          return const SizedBox();
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),

          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // Checkbox column
                SizedBox(
                  width: 50,

                  child: Center(
                    child: Checkbox(
                      value: widget.selected,

                      onChanged: (value) {
                        widget.onChanged(value ?? false);
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Payload column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: content.payloads.map((payload) {
                        return MenuPayloadWidget(identifier: payload);
                      }).toList(),
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
