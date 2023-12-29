import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/pages/bought_page.dart';
import 'package:travel_app/pages/favorite_page.dart';
import 'package:travel_app/pages/profile_page.dart';
import 'package:travel_app/pages/recommend_page.dart';

import '../model/users.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  //Lấy ra User hiện tại trong FirebaseAuthen
  final user_auth = FirebaseAuth.instance.currentUser!;

  //Lấy dữ liệu User từ FireStore thông qua Email của FirebaseAuthen
  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('email', isEqualTo: user_auth.email);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    } else {
      throw Exception('No user found with this email');
    }
  }

  //Thanh BottomBar
  @override
  Widget build(BuildContext context) {
    bool showNav = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      // backgroundColor: Color(0xffedede9),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !showNav,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                // Colors.white.withOpacity(1.0),
                // Colors.white.withOpacity(0.9),
                // Colors.white.withOpacity(0.7),
                // Colors.white.withOpacity(0.5),
                // Colors.white.withOpacity(0.3),
                // Colors.white.withOpacity(0.0),
                Colors.grey.shade300.withOpacity(1.0),
                Colors.grey.shade300.withOpacity(0.9),
                Colors.grey.shade300.withOpacity(0.7),
                Colors.grey.shade300.withOpacity(0.5),
                Colors.grey.shade300.withOpacity(0.3),
                Colors.grey.shade300.withOpacity(0.0),

              ],
               // Các điểm dừng tương ứng với mỗi dải màu
            ),
          ),
          child: SalomonBottomBar(
            unselectedItemColor: Color(0xff8d99ae),
            currentIndex: _currentIndex,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            // margin: EdgeInsets.only(left: 15,right: 15, bottom: 20),
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.house, size: 20),
                title: Text('Home'),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.radio, size: 20),
                  title: Text('Recommend'),
                  selectedColor: Colors.blue),
              SalomonBottomBarItem(
                icon: Icon(FontAwesomeIcons.solidHeart, size: 20),
                title: Text('Like'),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.briefcase, size: 20),
                  title: Text('Purchased'),
                  selectedColor: Colors.green),
              SalomonBottomBarItem(
                  icon: Icon(FontAwesomeIcons.solidUser, size: 20),
                  title: Text('Profile'),
                  selectedColor: Colors.black54)
            ],
          ),
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
                      RecommendPage(users: users),
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
