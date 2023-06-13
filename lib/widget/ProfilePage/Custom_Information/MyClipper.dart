import 'package:flutter/cupertino.dart';

class MyClipper implements CustomClipper<Rect>{

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  Rect getApproximateClipRect(Size size) {
    // TODO: implement getApproximateClipRect
    throw UnimplementedError();
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