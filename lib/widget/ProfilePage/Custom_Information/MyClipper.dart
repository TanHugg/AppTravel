import 'package:flutter/cupertino.dart';

class MyClipper implements CustomClipper<Rect> {
  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  Rect getApproximateClipRect(Size size) {
    // TODO: implement getApproximateClipRect
    final rectWidth = size.width / 2;
    final rectHeight = size.height / 2;
    final rectLeft = (size.width - rectWidth) / 2;
    final rectTop = (size.height - rectHeight) / 2;
    return Rect.fromLTRB(
        rectLeft, rectTop, rectLeft + rectWidth, rectTop + rectHeight);
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
  }
}
