import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

class ScriptItemWidget extends StatefulWidget {
  final Identifier identifier;

  const ScriptItemWidget({super.key, required this.identifier});

  @override
  State<ScriptItemWidget> createState() => _ScriptItemWidgetState();
}

class _ScriptItemWidgetState extends State<ScriptItemWidget> {
  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      ScriptEventRetrieveBySku(sku: widget.identifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, bool>(
      selector: (state) => state.fetching.contains(widget.identifier.sku),
      builder: (context, fetching) {
        if (fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocSelector<ScriptBloc, ScriptState, Script?>(
          selector: (state) => state.scripts[widget.identifier.sku],
          builder: (context, script) {
            if (script == null) {
              return const Text("Script not found");
            }

            if (script.contents.isEmpty) {
              return const Text("No contents");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: script.contents.length,
              itemBuilder: (context, index) {
                return _ContentPayloads(identifier: script.contents[index]);
              },
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
    context.read<ContentBloc>().add(
      ContentEventRetriveBySku(widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ContentBloc, ContentState, Content?>(
      selector: (state) => state.contents[widget.identifier.sku],
      builder: (context, content) {
        if (content == null) {
          return const Text("Content not found");
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: content.payloads.length,
          itemBuilder: (context, index) {
            return _PayloadItem(identifier: content.payloads[index]);
          },
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
    context.read<PayloadBloc>().add(
      PayloadEventRetrieveBySku(widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PayloadBloc, PayloadState, Payload?>(
      selector: (state) => state.payloads[widget.identifier.sku],
      builder: (context, payload) {
        if (payload == null) {
          return const Text("Payload not found");
        }

        return ListTile(title: Text(payload.sku));
      },
    );
  }
}
