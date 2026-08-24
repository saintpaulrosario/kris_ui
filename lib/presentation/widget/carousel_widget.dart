import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<Widget> items;
  const CarouselWidget({super.key, required this.items});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget>
    with AutomaticKeepAliveClientMixin {
  static const double _defaultHeight = 150;
  static const double _indicatorHeight = 10;
  static const int _maxIndicators = 5;
  late final ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    _currentIndex = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CarouselWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.isEmpty) {
      _currentIndex.value = 0;
    } else if (_currentIndex.value >= widget.items.length) {
      _currentIndex.value = widget.items.length - 1;
    }

    // Only fetch when the identifiers actually changed.
    if (widget.items != oldWidget.items && widget.items.isNotEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : _defaultHeight;

        final carouselHeight = widget.items.length > 1
            ? (availableHeight - _indicatorHeight).clamp(0.0, double.infinity)
            : availableHeight;
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return widget.items.elementAt(index);
              },
              options: CarouselOptions(
                height: carouselHeight,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  _currentIndex.value = index;
                },
              ),
            ),

            if (widget.items.length > 1)
              SizedBox(
                height: _indicatorHeight - 1,
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndex,
                  builder: (context, currentIndex, child) {
                    return _buildIndicators(
                      context,
                      currentIndex,
                      widget.items.length,
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

  @override
  bool get wantKeepAlive => true;
}
