import 'package:built_collection/built_collection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/medium/medium_state.dart';
import 'package:kris/model/medium.dart';
import 'package:kris/presentation/widget/image_widget.dart';
import 'package:kris/presentation/widget/sound_wiget.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/identifier.dart';

class SoundListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  State<SoundListWidget> createState() => _SoundListWidgetState();
}

class _SoundListWidgetState extends State<SoundListWidget>
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
  void didUpdateWidget(covariant SoundListWidget oldWidget) {
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
      return const SizedBox(child: Icon(Icons.volume_off));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : _defaultHeight;

        final carouselHeight = identifiers.length > 1
            ? (availableHeight - _indicatorHeight).clamp(0.0, double.infinity)
            : availableHeight;

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
            return Column(
              children: [
                CarouselSlider.builder(
                  itemCount: widget.identifiers.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                        if (!state.containsKey(
                          identifiers.elementAt(index).sku,
                        )) {
                          return Icon(Icons.volume_off);
                        }
                        Medium sound = state[identifiers.elementAt(index).sku]!;
                        return SoundWidget(
                          key: ValueKey(identifiers[index].sku),
                          sound: sound,
                        );
                      },
                  options: CarouselOptions(
                    height: carouselHeight,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      if (!mounted) {
                        return;
                      }

                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),

                if (identifiers.length > 1) ...[
                  SizedBox(
                    height: _indicatorHeight - 1,
                    child: _buildIndicators(context),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildIndicators(BuildContext context) {
    final total = widget.identifiers.length;

    final count = total > _maxIndicators ? _maxIndicators : total;

    int start = _currentIndex - (count ~/ 2);

    if (start < 0) {
      start = 0;
    }

    if (start > total - count) {
      start = total - count;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final actualIndex = start + index;

        return _buildDot(context, actualIndex);
      }),
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final selected = index == _currentIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: selected ? 10 : 6,
        height: selected ? 6 : 4,
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
