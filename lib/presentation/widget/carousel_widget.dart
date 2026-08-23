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
  int _currentIndex = 0;
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
                  if (!mounted) {
                    return;
                  }

                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),

            if (widget.items.length > 1) ...[
              SizedBox(
                height: _indicatorHeight - 1,
                child: _buildIndicators(context),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildIndicators(BuildContext context) {
    final total = widget.items.length;

    final count = total;

    int start = _currentIndex - (total ~/ 2);

    if (start < 0) {
      start = 0;
    }

    if (start > total) {
      start = total - 1;
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
