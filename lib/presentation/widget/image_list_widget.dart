import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/image_item_widget.dart';

import '../../model/identifier.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> imagesIdentifiers;

  const ImageListWidget({super.key, required this.imagesIdentifiers});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  static const int _maxIndicators = 5;
  static const double _imageHeight = 120;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imagesIdentifiers.isEmpty) {
      return const SizedBox(
        width: 120,
        height: _imageHeight,
        child: Center(child: Text("No image")),
      );
    }

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: widget.imagesIdentifiers.length,
            itemBuilder: (context, index, realIndex) {
              final identifier = widget.imagesIdentifiers[index];

              return ImageItemWidget(imageIdentifier: identifier);
            },
            options: CarouselOptions(
              height: 130,
              viewportFraction: 1,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          if (widget.imagesIdentifiers.length > 1) ...[
            const SizedBox(height: 8),
            _buildIndicators(context),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicators(BuildContext context) {
    final total = widget.imagesIdentifiers.length;

    final List<Widget> dots;

    if (total <= widget.imagesIdentifiers.length) {
      dots = List.generate(total, (index) => _buildDot(context, index));
    } else {
      int start = _currentIndex - (_maxIndicators ~/ 2);

      if (start < 0) {
        start = 0;
      }

      if (start > total - widget.imagesIdentifiers.length) {
        start = total - _maxIndicators;
      }

      dots = List.generate(
        widget.imagesIdentifiers.length,
        (i) => _buildDot(context, start + i),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    final selected = index == _currentIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: selected ? 10 : 6,
        height: selected ? 10 : 6,
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
