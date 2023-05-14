import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/pages/favorite_page.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {//FORM TRANG CHỦ
    return Scaffold(
      backgroundColor: Color(0xffedede9),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: SalomonBottomBar(//THANH BÊN DƯỚI
          unselectedItemColor: Color(0xff8d99ae),
          currentIndex: _currentIndex,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            SalomonBottomBarItem(//NÚT VÀO TRANG HOME
              icon: Icon(FontAwesomeIcons.house, size: 25),
              title: Text('Home'),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(//NÚT VÀO TRANG FAVORITE
              icon: Icon(FontAwesomeIcons.solidHeart, size: 25),
              title: Text('Like'),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(//NÚT VÀO TOUR ĐÃ MUA
                icon: Icon(FontAwesomeIcons.briefcase, size: 25),
                title: Text('Bought Tours'),
                selectedColor: Colors.green),
            SalomonBottomBarItem(//NÚT VÀO PROFILE
                icon: Icon(FontAwesomeIcons.solidUser, size: 25),
                title: Text('Profile'),
                selectedColor: Colors.black54)
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          FavoritePage(),
          Container(color: Colors.orange),
          Container(color: Colors.pink),
        ],
      ),
    );
  }
}
