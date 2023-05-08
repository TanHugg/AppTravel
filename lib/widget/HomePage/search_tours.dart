import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchTours extends StatelessWidget {
  const SearchTours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 470,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xfff4f3ee)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Container(
                  alignment: Alignment.center,
                  width: 44,
                  height: 50,
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 22,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, bottom: 3, top: 11),
              child: Container(
                width: 240,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 23,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Search place', border: InputBorder.none),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
