import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'viewer_widget.dart';

class CarouselWidget extends StatelessWidget {
  final List<Widget> items;
  final bool autoPlay;
  CarouselWidget({super.key, required this.items, required this.autoPlay});

  static const double _defaultHeight = 150;
  static const double _indicatorHeight = 10;
  static const int _maxIndicators = 5;
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  // @override
  // void didUpdateWidget(covariant CarouselWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (widget.items.isEmpty) {
  //     _currentIndex.value = 0;
  //   } else if (_currentIndex.value >= widget.items.length) {
  //     _currentIndex.value = widget.items.length - 1;
  //   }

  //   // Only fetch when the identifiers actually changed.
  //   if (widget.items != oldWidget.items && widget.items.isNotEmpty) {}
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : _defaultHeight;

        final carouselHeight = items.length > 1
            ? (availableHeight - _indicatorHeight).clamp(0.0, double.infinity)
            : availableHeight;
        return Column(
          children: [
            InkWell(
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        ViewerWidget(mediums: items, autoPlay: autoPlay),
                  ),
                ),
              },
              child: CarouselSlider.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return items.elementAt(index);
                },
                options: CarouselOptions(
                  height: carouselHeight,
                  viewportFraction: 1.0,
                  autoPlay: autoPlay,
                  reverse: true,
                  autoPlayInterval: const Duration(minutes: 1),
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    _currentIndex.value = index;
                  },
                ),
              ),
            ),

            if (items.length > 1)
              SizedBox(
                height: _indicatorHeight - 1,
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, currentIndex, child) {
                    return _buildIndicators(
                      context,
                      currentIndex,
                      items.length,
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildIndicators(BuildContext context, int currentIndex, int total) {
    final count = total > _maxIndicators ? _maxIndicators : total;

    int start = currentIndex - (count ~/ 2);

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

        return GestureDetector(
          onTap: () => _currentIndex.value = index,
          child: _buildDot(context, actualIndex, currentIndex),
        );
      }),
    );
  }

  Widget _buildDot(BuildContext context, int index, int currentIndex) {
    final selected = index == currentIndex;

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
}
