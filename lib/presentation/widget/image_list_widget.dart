import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'image_item_widget.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> imagesIdentifiers;

  const ImageListWidget({super.key, required this.imagesIdentifiers});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  static const int _maxIndicators = 5;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imagesIdentifiers.isEmpty) {
      return const Center(child: Text("No image"));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imagesIdentifiers.length,
          itemBuilder: (context, index, realIndex) {
            final identifier = widget.imagesIdentifiers[index];

            return Card(
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                boundaryMargin: const EdgeInsets.all(100),
                child: SizedBox.expand(
                  child: ImageItemWidget(
                    key: ValueKey('${identifier.sku}-$index'),
                    imageIdentifier: identifier,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
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
        const SizedBox(height: 8),
        _buildIndicators(context),
        const SizedBox(height: 4),
        Text(
          '${_currentIndex + 1} / ${widget.imagesIdentifiers.length}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildIndicators(BuildContext context) {
    final total = widget.imagesIdentifiers.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Not enough room to display indicators.
        if (constraints.maxWidth < 40) {
          return const SizedBox.shrink();
        }

        final List<Widget> dots;

        if (total <= _maxIndicators) {
          dots = List.generate(total, (index) => _buildDot(context, index));
        } else {
          int start = _currentIndex - (_maxIndicators ~/ 2);

          if (start < 0) {
            start = 0;
          }

          if (start > total - _maxIndicators) {
            start = total - _maxIndicators;
          }

          dots = List.generate(
            _maxIndicators,
            (i) => _buildDot(context, start + i),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(mainAxisSize: MainAxisSize.min, children: dots),
        );
      },
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
