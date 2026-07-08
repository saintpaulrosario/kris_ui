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
  @override
  void initState() {
    context.read<ScriptBloc>().add(RetrieveScriptsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, Map<String, Script>>(
      selector: (state) => state.scripts,
      builder: (context, state) {
        if (state.isEmpty) {
          return Text("No scripts available for selection");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.values.length,
          itemBuilder: (context, index) {
            Script script = state.values.elementAt(index);
            return Card(child: ScriptMenuItemWidget(script: script));
          },
        );
      },
    );
  }
}

class ScriptMenuItemWidget extends StatelessWidget {
  final Script script;

  const ScriptMenuItemWidget({super.key, required this.script});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, bool>(
      selector: (state) => state.fetching.contains(script.sku),
      builder: (context, fetching) {
        if (fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocSelector<ScriptBloc, ScriptState, Script?>(
          selector: (state) => state.scripts[script.sku],
          builder: (context, script) {
            if (script == null) {
              return const Text("Script not found");
            }

            if (script.contents.isEmpty) {
              return const Text("No contents");
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: script.contents
                  .map((identifier) => _ContentPayloads(identifier: identifier))
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class _ContentPayloads extends StatefulWidget {
  final Identifier identifier;

  const _ContentPayloads({required this.identifier});

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
          return const Text("Content not found");
        }

        if (content.payloads.isEmpty) {
          return const Text("No payloads");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content.payloads
              .map((identifier) => _PayloadItem(identifier: identifier))
              .toList(),
        );
      },
    );
  }
}

class _PayloadItem extends StatefulWidget {
  final Identifier identifier;

  const _PayloadItem({required this.identifier});

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
          return const Text("Payload not found");
        }

        return Text(payload.value);
      },
    );
  }
}
