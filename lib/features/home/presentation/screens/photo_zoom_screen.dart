import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:zest_trip/config/utils/constants/color_constant.dart';

class PhotoZoomScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const PhotoZoomScreen(
      {super.key, required this.imageUrls, required this.initialIndex});

  @override
  _PhotoZoomScreenState createState() => _PhotoZoomScreenState();
}

class _PhotoZoomScreenState extends State<PhotoZoomScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentPage = widget.initialIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(scrolledUnderElevation: 0,
        foregroundColor: whiteColor,
        backgroundColor: Colors.black,
        title: Text(
          '$_currentPage/${widget.imageUrls.length}',
          style: const TextStyle(color: whiteColor),
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: widget.imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(widget.imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index + 1;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
