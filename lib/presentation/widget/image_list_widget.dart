import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/image_item_widget.dart';

import '../../model/identifier.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ImageListWidget({super.key, required this.identifiers});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  static const int _maxIndicators = 5;

  static const double _carouselHeight = 150;

  int _currentIndex = 0;

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
    final identifiers = widget.identifiers;

    if (identifiers.isEmpty) {
      return const SizedBox(
        width: double.infinity,
        height: _carouselHeight,
        child: Icon(Icons.image_not_supported),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 42,
          child: CarouselSlider.builder(
            itemCount: identifiers.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return SizedBox(
                width: double.infinity,
                height: _carouselHeight,
                child: ImageItemWidget(
                  key: ValueKey(identifiers[index].sku),
                  imageIdentifier: identifiers[index],
                ),
              );
            },
            options: CarouselOptions(
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
        ),

        if (identifiers.length > 1) ...[
          const SizedBox(height: 1),
          _buildIndicators(context),
        ],
      ],
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

    return SizedBox(
      width: double.infinity,
      height: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (index) {
          final actualIndex = start + index;

          return _buildDot(context, actualIndex);
        }),
      ),
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final selected = index == _currentIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: AnimatedContainer(
        duration: const Duration(seconds: 30),
        width: selected ? 10 : 6,
        height: selected ? 10 : 6,
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}
