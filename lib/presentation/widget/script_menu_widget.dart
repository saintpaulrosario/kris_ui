import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

class ScriptMenuListWidget extends StatefulWidget {
  const ScriptMenuListWidget({super.key});

  @override
  State<ScriptMenuListWidget> createState() => _ScriptMenuListWidgetState();
}

class _ScriptMenuListWidgetState extends State<ScriptMenuListWidget> {
  final Set<String> selectedContents = {};

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

        final scriptList = scripts.values.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            MenuAnchor(
              menuChildren: [
                SizedBox(
                  width: 350,

                  height: 400,

                  child: Scrollbar(
                    thumbVisibility: true,

                    child: ListView.builder(
                      padding: EdgeInsets.zero,

                      itemCount: scriptList.length,

                      itemBuilder: (context, scriptIndex) {
                        final script = scriptList[scriptIndex];

                        return Column(
                          children: [
                            if (scriptIndex > 0) const Divider(),

                            ...script.contents.map((contentIdentifier) {
                              return _ContentGroup(
                                identifier: contentIdentifier,

                                selected: selectedContents.contains(
                                  contentIdentifier.sku,
                                ),

                                onChanged: (value) {
                                  setState(() {
                                    if (value) {
                                      selectedContents.add(
                                        contentIdentifier.sku,
                                      );
                                    } else {
                                      selectedContents.remove(
                                        contentIdentifier.sku,
                                      );
                                    }
                                  });
                                },
                              );
                            }),
                          ],
                        );
                      },
                    ),
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
                      labelText: "Select Payload Group",

                      border: OutlineInputBorder(),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          selectedContents.isEmpty
                              ? "Select"
                              : "${selectedContents.length} selected",
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

            const SizedBox(height: 20),

            const Text(
              "Selected:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...scripts.values
                .expand((script) => script.contents)
                .where((content) => selectedContents.contains(content.sku))
                .map((content) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),

                      child: _SelectedContent(identifier: content),
                    ),
                  );
                }),
          ],
        );
      },
    );
  }
}

class _ContentGroup extends StatefulWidget {
  final Identifier identifier;

  final bool selected;

  final Function(bool) onChanged;

  const _ContentGroup({
    required this.identifier,

    required this.selected,

    required this.onChanged,
  });

  @override
  State<_ContentGroup> createState() => _ContentGroupState();
}

class _ContentGroupState extends State<_ContentGroup> {
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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CheckboxListTile(
              title: const Text(""),

              value: widget.selected,

              onChanged: (value) {
                widget.onChanged(value ?? false);
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 50),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: content.payloads.map((payload) {
                  return _PayloadText(identifier: payload);
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PayloadText extends StatefulWidget {
  final Identifier identifier;

  const _PayloadText({required this.identifier});

  @override
  State<_PayloadText> createState() => _PayloadTextState();
}

class _PayloadTextState extends State<_PayloadText> {
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

        return Text(payload.value);
      },
    );
  }
}

class _SelectedContent extends StatelessWidget {
  final Identifier identifier;

  const _SelectedContent({required this.identifier});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ContentBloc, ContentState, Content?>(
      selector: (state) => state.contents[identifier.sku],

      builder: (context, content) {
        if (content == null) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ...content.payloads.map((payload) {
              return _PayloadText(identifier: payload);
            }),
          ],
        );
      },
    );
  }
}
