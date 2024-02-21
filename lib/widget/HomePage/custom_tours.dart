import 'package:flutter/material.dart';

class CustomATours extends StatelessWidget { //Class này dùng để custom tour
  const CustomATours(                       //Để hiển thị từ ListView lên Layout
      {Key? key,
      required this.nameImage,
      required this.nameTour,
      required this.startDay,
      required this.startMonth,
      required this.startYear,
      required this.widSizeBox,
      required this.heiSizeBox,
      required this.widContain,
      required this.heiContain,
      required this.money})
      : super(key: key);

  final String nameImage;
  final String nameTour;
  final int startDay;
  final int startMonth;
  final int startYear;
  final double widSizeBox;
  final double heiSizeBox;
  final double widContain;
  final double heiContain;
  final String money;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: widSizeBox,
            height: heiSizeBox,
            child: Image.asset(
              "assets/images/picture_tours/${nameImage}.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        customDetailATour(10, 10, 150, heiContain, nameTour.toString()),
        customDetailATour(
            10, 170, 110, heiContain, '${startDay}/${startMonth}/${startYear}'),
        customDetailATour(120, 220, 125, heiContain, money.toString()),
      ],
    );
  }
}

Widget customDetailATour(double topPos, double leftPos, double widContain,
    double heiContain, String money) {
  return Positioned(
      top: topPos,
      left: leftPos,
      child: Container(
        width: widContain,
        height: heiContain,
        decoration: BoxDecoration(
            color: Color(0xfff1faee), borderRadius: BorderRadius.circular(21)),
        child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              money.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
      ));
}
