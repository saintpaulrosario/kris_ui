import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

class ScriptMenuListWidget extends StatefulWidget {
  const ScriptMenuListWidget({super.key});

  @override
  State<ScriptMenuListWidget> createState() => _ScriptMenuListWidgetState();
}

class _ScriptMenuListWidgetState extends State<ScriptMenuListWidget> {
  final Set<String> selectedPayloads = {};

  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
      selector: (state) => state.scripts,

      builder: (context, scripts) {
        if (scripts.isEmpty) {
          return const Text("No scripts available");
        }

        return MenuAnchor(
          menuChildren: [
            SizedBox(
              width: 350,
              height: 400,

              child: ListView(
                children: [
                  ...scripts.values.map((script) {
                    final scriptIndex = scripts.values.toList().indexOf(script);

                    return Column(
                      children: [
                        if (scriptIndex > 0) const Divider(),

                        ...script.contents.map((contentIdentifier) {
                          return _ContentPayloads(
                            identifier: contentIdentifier,
                            selectedPayloads: selectedPayloads,

                            onChanged: (String sku, bool value) {
                              setState(() {
                                if (value) {
                                  selectedPayloads.add(sku);
                                } else {
                                  selectedPayloads.remove(sku);
                                }
                              });
                            },
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],

          builder: (context, controller, child) {
            return InkWell(
              onTap: () {
                controller.isOpen ? controller.close() : controller.open();
              },

              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Select Payloads",
                  border: OutlineInputBorder(),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      selectedPayloads.isEmpty
                          ? "Select Payloads"
                          : "${selectedPayloads.length} selected",
                    ),

                    Icon(
                      controller.isOpen
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ContentPayloads extends StatefulWidget {
  final dynamic identifier;
  final Set<String> selectedPayloads;
  final Function(String sku, bool value) onChanged;

  const _ContentPayloads({
    required this.identifier,
    required this.selectedPayloads,
    required this.onChanged,
  });

  @override
  State<_ContentPayloads> createState() => _ContentPayloadsState();
}

class _ContentPayloadsState extends State<_ContentPayloads> {
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
      selector: (state) => state.contents[widget.identifier.sku],

      builder: (context, content) {
        if (content == null) {
          return const SizedBox();
        }

        return Column(
          children: content.payloads.map((payloadIdentifier) {
            return _PayloadItem(
              identifier: payloadIdentifier,

              checked: widget.selectedPayloads.contains(payloadIdentifier.sku),

              onChanged: widget.onChanged,
            );
          }).toList(),
        );
      },
    );
  }
}

class _PayloadItem extends StatefulWidget {
  final dynamic identifier;
  final bool checked;
  final Function(String sku, bool value) onChanged;

  const _PayloadItem({
    required this.identifier,
    required this.checked,
    required this.onChanged,
  });

  @override
  State<_PayloadItem> createState() => _PayloadItemState();
}

class _PayloadItemState extends State<_PayloadItem> {
  @override
  void initState() {
    super.initState();

    context.read<PayloadBloc>().add(
      PayloadEventRetrieveBySku(widget.identifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PayloadBloc, PayloadState, Payload?>(
      selector: (state) => state.payloads[widget.identifier.sku],

      builder: (context, payload) {
        if (payload == null) {
          return const SizedBox();
        }

        return CheckboxListTile(
          title: Text(payload.value),

          value: widget.checked,

          onChanged: (value) {
            widget.onChanged(widget.identifier.sku, value ?? false);
          },
        );
      },
    );
  }
}
