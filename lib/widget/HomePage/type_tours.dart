import 'package:flutter/material.dart';
import '../../values/custom_text.dart';

String checkType = '';

class TypeTours extends StatefulWidget {
  const TypeTours({Key? key, required this.refreshLayout}) : super(key: key);

  final VoidCallback refreshLayout; //Là function bên kia a

  @override
  State<TypeTours> createState() => _TypeToursState();

  String checkTypeTours() {
    return checkType;
  }
}

class _TypeToursState extends State<TypeTours> {
  void _listenRefresh() {
    widget.refreshLayout();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
          TypeContainer("beach", "Biển", () {
            setState(() {
              _listenRefresh();
              checkType = 'beach';
              print('Bạn đã nhấn vào Beach');
            });
          }),
          SizedBox(width: 11),
          TypeContainer("tent", "Núi", () {
            setState(() {
              _listenRefresh();
              checkType = 'mountain';
              print('Bạn đã nhấn vào Moutain');
            });
          }),
          SizedBox(width: 11),
          TypeContainer("city", "Thành Phố", () {
            setState(() {
              _listenRefresh();
              checkType = 'city';
              print('Bạn đã nhấn vào City');
            });
          }),
        ]),
      ),
    );
  }

  Widget TypeContainer(String nameImage, String nameType, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60, width: 190, //Mountain
        decoration: BoxDecoration(
            color: Color(0xfff4f3ee), borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(7),
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset('assets/images/${nameImage.toString()}.png'),
              decoration: BoxDecoration(
                color: Color(0xffedede9),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            CustomText(
                text: nameType,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
                height: 0,
                color: Colors.black),
          ],
        ),
      ),
    );
  }
}
