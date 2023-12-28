import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/pages/admin_page.dart';
import 'package:travel_app/pages/login_page.dart';

import 'main_page.dart';

class IntroducePage extends StatelessWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/introduce.jpg',
              fit: BoxFit.cover, height: size.height, width: size.width),
          Positioned(
            top: (size.height * 2 / 3) - 20,
            child: Container(
                height: (size.height * 1 / 3) + 20,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  child: Column(
                    children: <Widget>[
                      TextIntroduce("Your Journey in", 35, Colors.white),
                      TextIntroduce("Your Hands", 35, Colors.white),
                      const SizedBox(height: 15),
                      TextIntroduce(
                          "The best travel app in 2023", 15, Colors.white54),
                      TextIntroduce("Answer for traveler to find their journey",
                          15, Colors.white54),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 200), //Xem lại
                        child: SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                bool isLoggedIn =
                                    prefs.getBool('loggedIn') ?? false;
                                bool isUser = prefs.getBool('User') ?? false;
                                if (isLoggedIn && isUser) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MainPage()),
                                  );
                                } else if (isLoggedIn && !isUser) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminPage()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF5B5B),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              child: const Text('Bắt đầu',
                                  style: TextStyle(fontSize: 23, color: Colors.white)),
                            )),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

// ( Này là Widget của cái giới thiệu. Tại nó sài nhiều nên viết ra tối ưu)
// ignore: non_constant_identifier_names
Widget TextIntroduce(String words, double fontSize, Color colors) {
  return Text(words,
      style: GoogleFonts.plusJakartaSans(fontSize: fontSize, color: colors));
}
