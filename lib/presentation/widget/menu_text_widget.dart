import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/logic/text/word_text.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/content/content.dart';
import '../../model/identifier.dart';
import 'menu_payload_widget.dart';

class MenuTextWidget extends StatefulWidget {
  final Identifier identifier;

  final bool selected;

  final Function(bool) onChanged;

  const MenuTextWidget({
    super.key,
    required this.identifier,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<MenuTextWidget> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuTextWidget> {
  @override
  void initState() {
    context.read<WordTextBloc>().add(
      WordTextEventRetrieveByIdentifier(identifier: widget.identifier),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordTextBloc, WordTextState, WordText?>(
      selector: (state) => state.data[widget.identifier.sku],

      builder: (context, state) {
        if (state == null) {
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

                      children: [Text(state.text)],
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
