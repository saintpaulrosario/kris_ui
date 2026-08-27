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

  late bool _isPlaying;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();

    _isPlaying = widget.autoPlay;
  }

  @override
  void didUpdateWidget(covariant ViewerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.autoPlay != widget.autoPlay) {
      _isPlaying = widget.autoPlay;

      if (_isPlaying) {
        _carouselController.startAutoPlay();
      } else {
        _carouselController.stopAutoPlay();
      }
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _carouselController.startAutoPlay();
    } else {
      _carouselController.stopAutoPlay();
    }
  }

  void _showControlsOnTap() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _showControls = true;
            });
          },
          onExit: (_) {
            setState(() {
              _showControls = false;
            });
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _showControlsOnTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // CAROUSEL
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: widget.mediums.length,
                  options: CarouselOptions(
                    autoPlay: widget.autoPlay,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: widget.mediums.length > 1,
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
                        return InteractiveViewer(
                          minScale: 1,
                          maxScale: 5,
                          panEnabled: true,
                          child: widget.mediums[index],
                        );
                      },
                ),

                // PLAY / PAUSE BUTTON
                if (widget.mediums.length > 1)
                  Visibility(
                    visible: _showControls,
                    child: IconButton(
                      iconSize: 64,
                      color: Colors.white,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black54,
                        padding: const EdgeInsets.all(8),
                      ),
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                      ),
                      onPressed: _togglePlayPause,
                    ),
                  ),

                // PREVIOUS BUTTON
                if (widget.mediums.length > 1)
                  Positioned(
                    left: 10,
                    child: Visibility(
                      visible: _showControls,
                      child: IconButton(
                        onPressed: () {
                          _carouselController.previousPage();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),

                // NEXT BUTTON
                if (widget.mediums.length > 1)
                  Positioned(
                    right: 10,
                    child: Visibility(
                      visible: _showControls,
                      child: IconButton(
                        onPressed: () {
                          _carouselController.nextPage();
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 32,
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
          ),
        ),
      ),
    );
  }
}
