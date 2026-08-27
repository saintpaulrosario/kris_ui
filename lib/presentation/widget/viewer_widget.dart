import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ViewerWidget extends StatefulWidget {
  final List<Widget> mediums;
  final bool autoPlay;

  const ViewerWidget({
    super.key,
    required this.mediums,
    required this.autoPlay,
  });

  @override
  State<ViewerWidget> createState() => _ViewerWidgetState();
}

class _ViewerWidgetState extends State<ViewerWidget> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [
            // IMAGE AREA
            Stack(
              alignment: Alignment.center,
              children: [
                // CAROUSEL
                Center(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.mediums.length,
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration: const Duration(
                        milliseconds: 800,
                      ),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                          return Expanded(
                            child: InteractiveViewer(
                              minScale: 1,
                              maxScale: 5,
                              panEnabled: true,
                              child: widget.mediums[index],
                            ),
                          );
                        },
                  ),
                ),

                // PREVIOUS / BACK ARROW
                if (_currentIndex > 0)
                  Positioned(
                    left: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        _carouselController.previousPage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 8),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(-value, 0),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.green,
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                // NEXT ARROW
                if (_currentIndex < widget.mediums.length - 1)
                  Positioned(
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        _carouselController.nextPage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 8),
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(value, 0),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blue,
                                size: 32,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                // CLOSE BUTTON
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
