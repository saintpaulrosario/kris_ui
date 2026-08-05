import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../widget/script_list_widget.dart';

class ScriptMenu extends StatefulWidget {
  const ScriptMenu({super.key});

  @override
  State<ScriptMenu> createState() => _ScriptMenuState();
}

class _ScriptMenuState extends State<ScriptMenu> {
  final OverlayPortalController _controller = OverlayPortalController();

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScriptBloc, ScriptState>(
      builder: (context, state) {
        return OverlayPortal(
          controller: _controller,

          overlayChildBuilder: (context) {
            return CompositedTransformFollower(
              link: _layerLink,

              showWhenUnlinked: false,

              offset: const Offset(0, 60),

              child: Align(
                alignment: Alignment.topLeft,

                child: Material(
                  elevation: 8,

                  borderRadius: BorderRadius.circular(8),

                  child: SizedBox(
                    width: 350,
                    height: 300,

                    child: ScriptListWidget(
                      identifiers: state.data.values.toList(),
                    ),
                  ),
                ),
              ),
            );
          },

          child: CompositedTransformTarget(
            link: _layerLink,

            child: InkWell(
              onTap: () {
                if (_controller.isShowing) {
                  _controller.hide();
                } else {
                  _controller.show();
                }
              },

              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Script",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.selections.isEmpty
                            ? "Select"
                            : "${state.selections.length} selected",

                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Icon(
                      _controller.isShowing
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
