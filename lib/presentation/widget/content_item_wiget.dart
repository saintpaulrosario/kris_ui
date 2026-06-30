import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../model/content.dart';

class ContentItemWidget extends StatefulWidget {
  final Identifier identifier;
  const ContentItemWidget({super.key, required this.identifier});

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    context.read<ContentBloc>().add(
      ContentEventRetriveBySku(widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ContentBloc, ContentState, bool>(
      selector: (ContentState state) {
        return state.fetching.contains(widget.identifier.sku);
      },
      builder: (context, state) {
        if (state) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return BlocSelector<ContentBloc, ContentState, Map<String, Content>>(
            selector: (state) {
              return state.contents;
            },
            builder: (context, state) {
              if (state.isEmpty) {
                return const Center(child: Text("No content available"));
              } else if (!state.containsKey(widget.identifier.sku)) {
                return const Center(child: Text("Content not found"));
              } else {
                return BlocSelector<ContentBloc, ContentState, Content>(
                  selector: (state) {
                    return state.contents[widget.identifier.sku]!;
                  },
                  builder: (context, state) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text("(row,ordinal)"),
                                  Text(
                                    "${state.row.toString()}, ${state.ordinal.toString()}",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SoundListWidget(sounds: state.sounds),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text(state.payload)],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text("definition")],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
