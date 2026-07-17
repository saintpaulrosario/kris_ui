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
            return Card(
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 5.0,
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(100),
                child: SizedBox.expand(
                  child: ImageItemWidget(
                    imageIdentifier: widget.imagesIdentifiers[index],
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imagesIdentifiers.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentIndex == index ? 12 : 8,
              height: _currentIndex == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
