import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/medium/medium_state.dart';
import 'package:kris/model/medium.dart';
import 'package:kris/presentation/widget/audio_widget.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../model/identifier.dart';

class SoundListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  State<SoundListWidget> createState() => _SoundListWidgetState();
}

class _SoundListWidgetState extends State<SoundListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    if (widget.identifiers.isNotEmpty) {
      context.read<MediumBloc>().add(
        MediumEventFetchIdentifiers(identifiers: widget.identifiers),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final identifiers = widget.identifiers;

    if (identifiers.isEmpty) {
      return const SizedBox(child: Icon(Icons.volume_off));
    }

    return BlocSelector<
      MediumBloc,
      MediumState<Medium>,
      BuiltMap<String, Medium>
    >(
      selector: (state) {
        final skuSet = identifiers.map((identifier) => identifier.sku).toSet();

        return state.data.rebuild((builder) {
          builder.removeWhere((key, value) => !skuSet.contains(key));
        });
      },
      builder: (context, state) {
        List<AudioWidget> items = state.values
            .map((medium) => AudioWidget(audio: medium))
            .toList();
        return CarouselWidget(items: items);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
