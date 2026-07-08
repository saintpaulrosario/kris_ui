import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

class ScriptMenuWidget extends StatefulWidget {
  const ScriptMenuWidget({super.key});

  @override
  State<ScriptMenuWidget> createState() => _ScriptMenuWidgetState();
}

class _ScriptMenuWidgetState extends State<ScriptMenuWidget> {
  final Map<String, String> selectedPayloads = {};

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            MenuAnchor(
              menuChildren: [
                SizedBox(
                  width: 350,
                  height: 400,

                  child: ListView.builder(
                    itemCount: scripts.length,

                    itemBuilder: (context, index) {
                      final script = scripts.values.elementAt(index);

                      return Column(
                        children: [
                          if (index > 0) const Divider(),

                          ...script.contents.map((contentIdentifier) {
                            return _ContentLoader(
                              identifier: contentIdentifier,

                              selectedPayloads: selectedPayloads,

                              onChanged: _onPayloadChanged,
                            );
                          }),
                        ],
                      );
                    },
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
                      labelText: "Scrips",

                      border: OutlineInputBorder(),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          selectedPayloads.isEmpty
                              ? "Select Script"
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
            ),

            const SizedBox(height: 10),

            // Selected payload values
            Wrap(
              spacing: 8,

              runSpacing: 8,

              children: selectedPayloads.entries.map((entry) {
                return Chip(
                  label: Text(entry.value),

                  deleteIcon: const Icon(Icons.close),

                  onDeleted: () {
                    setState(() {
                      selectedPayloads.remove(entry.key);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  void _onPayloadChanged(String sku, String value, bool selected) {
    setState(() {
      if (selected) {
        selectedPayloads[sku] = value;
      } else {
        selectedPayloads.remove(sku);
      }
    });
  }
}

class _ContentLoader extends StatefulWidget {
  final Identifier identifier;

  final Map<String, String> selectedPayloads;

  final Function(String sku, String value, bool selected) onChanged;

  const _ContentLoader({
    required this.identifier,

    required this.selectedPayloads,

    required this.onChanged,
  });

  @override
  State<_ContentLoader> createState() => _ContentLoaderState();
}

class _ContentLoaderState extends State<_ContentLoader> {
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
            return _PayloadLoader(
              identifier: payloadIdentifier,

              checked: widget.selectedPayloads.containsKey(
                payloadIdentifier.sku,
              ),

              onChanged: widget.onChanged,
            );
          }).toList(),
        );
      },
    );
  }
}

class _PayloadLoader extends StatefulWidget {
  final Identifier identifier;

  final bool checked;

  final Function(String sku, String value, bool selected) onChanged;

  const _PayloadLoader({
    required this.identifier,

    required this.checked,

    required this.onChanged,
  });

  @override
  State<_PayloadLoader> createState() => _PayloadLoaderState();
}

class _PayloadLoaderState extends State<_PayloadLoader> {
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
            widget.onChanged(
              widget.identifier.sku,

              payload.value,

              value ?? false,
            );
          },
        );
      },
    );
  }
}
