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

  int _currentImage = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentImage = (_currentImage + 1) % images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage('${images[_currentImage]}'),
        fit: BoxFit.cover,
      );

  }
}
