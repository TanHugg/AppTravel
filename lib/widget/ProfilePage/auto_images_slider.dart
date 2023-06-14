import 'dart:async';

import 'package:flutter/material.dart';

class AutoImagesSlider extends StatefulWidget {
  const AutoImagesSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<AutoImagesSlider> createState() => _AutoImagesSliderState();
}

class _AutoImagesSliderState extends State<AutoImagesSlider> {
  List<String> images = [
    'assets/images/cover_images/Picture_1.jpg',
    'assets/images/cover_images/Picture_2.jpg',
    'assets/images/cover_images/Picture_3.jpg',
    'assets/images/cover_images/Picture_4.jpg',
    'assets/images/cover_images/Picture_5.jpg'
  ];
  late Timer _timer;
  int _currentImage = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentImage = (_currentImage + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy bỏ Timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage('${images[_currentImage]}'),
        fit: BoxFit.cover,
      );

  }
}
