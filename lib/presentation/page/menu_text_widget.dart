import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../model/identifier.dart';
import '../../model/script_text.dart';
import '../widget/script_content_widget.dart';

class MenuTextWidget extends StatefulWidget {
  final Identifier identifier;
  final bool selected;
  final ValueChanged<bool> onChanged;

  const MenuTextWidget({
    super.key,
    required this.identifier,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<MenuTextWidget> createState() => _MenuTextWidgetState();
}

class _MenuTextWidgetState extends State<MenuTextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      ScriptBloc,
      ScriptState,
      ({bool fetching, ScriptText? text})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        text: state.texts[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final text = state.text;

        if (text == null) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

          child: Padding(
            padding: const EdgeInsets.all(8),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: widget.selected,
                  onChanged: (value) {
                    if (value != null) {
                      widget.onChanged(value);
                    }
                  },
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final identifier in text.contents)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: ScriptContentWidget(
                            key: ValueKey(identifier.sku),
                            identifier: identifier,
                          ),
                        ),
                    ],
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
