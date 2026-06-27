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
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state.fetching == true && state.success == false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.fetching == false && state.success == false) {
          return const Center(child: Text('no content yet available.'));
        } else {
          Content content = state.selection;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(content.payload)],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [SoundListWidget(sounds: content.sounds)],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("definition")],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
