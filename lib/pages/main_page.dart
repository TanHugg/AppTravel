import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/pages/bought_page.dart';
import 'package:travel_app/pages/favorite_page.dart';
import 'package:travel_app/pages/profile_page.dart';

import '../model/users.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  final user_auth = FirebaseAuth.instance.currentUser!;

  //Lấy thuộc tính Email trong FirebaseStore collection Users
  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('email', isEqualTo: user_auth.email.toString());
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedede9),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: SalomonBottomBar(
          unselectedItemColor: Color(0xff8d99ae),
          currentIndex: _currentIndex,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.house, size: 25),
              title: Text('Home'),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.solidHeart, size: 25),
              title: Text('Like'),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.briefcase, size: 25),
                title: Text('Bought Tours'),
                selectedColor: Colors.green),
            SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.solidUser, size: 25),
                title: Text('Profile'),
                selectedColor: Colors.black54)
          ],
        ),
      ),
      body: FutureBuilder(
        future: readUsers(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final users = snapShot.data; //Đã lấy đủ dữ liệu bỏ vào users
            return users == null
                ? Center(child: Text('No Find User !'))
                : IndexedStack(
                    index: _currentIndex,
                    children: [
                      HomePage(users: users),
                      FavoritePage(users: users),
                      BoughtPage(users: users),
                      ProfilePage(users: users),
                    ],
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
