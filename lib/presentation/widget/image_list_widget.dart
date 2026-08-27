import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/medium/medium_state.dart';
import 'package:kris/model/medium.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';
import 'package:kris/presentation/widget/image_widget.dart';

import '../../model/identifier.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ImageListWidget({super.key, required this.identifiers});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget>
    with AutomaticKeepAliveClientMixin {
  static const int _maxIndicators = 5;
  static const double _defaultHeight = 150;
  static const double _indicatorHeight = 10;

  int _currentIndex = 0;

  @override
  void initState() {
    context.read<MediumBloc>().add(
      MediumEventFetchIdentifiers(identifiers: widget.identifiers),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.identifiers.isEmpty) {
      _currentIndex = 0;
    } else if (_currentIndex >= widget.identifiers.length) {
      _currentIndex = widget.identifiers.length - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final identifiers = widget.identifiers;

    if (identifiers.isEmpty) {
      return const SizedBox(child: Icon(Icons.image_not_supported));
    }

    return BlocSelector<
      MediumBloc,
      MediumState<Medium>,
      BuiltMap<String, Medium>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        return state.data.rebuild((builder) {
          builder.removeWhere((key, value) => !identifiers.contains(key));
        });
      },
      builder: (context, state) {
        List<ImageWidget> items = state.values
            .map((x) => ImageWidget(image: x))
            .toList();
        return CarouselWidget(items: items, autoPlay: true);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
