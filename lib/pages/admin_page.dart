import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/pages/introduce_page.dart';
import 'package:travel_app/widget/Admin/add_tour.dart';
import 'package:travel_app/widget/Admin/edit_tour.dart';
import 'package:travel_app/widget/Admin/show_bought_tour.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //Hàm đăng xuất
  Future<void> _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", false);
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Color(0xff051923),
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color(0xff6096ba)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 135,
                    height: 160,
                    child: Image.asset(
                      "assets/images/face_images/Face_4.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffbfdbf7),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 14),
                              Text('Tour đã đặt',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                      decoration: TextDecoration.none)),
                              SizedBox(height: 7),
                              Text('100',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 42,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                      decoration: TextDecoration.none)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 100,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffbfdbf7),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 14),
                              Text('Khách hàng',
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                      decoration: TextDecoration.none)),
                              SizedBox(height: 7),
                              Text('100',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 42,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                      decoration: TextDecoration.none)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(),
            child: Container(
              height: 500,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Admin',
                        style: GoogleFonts.sacramento(
                            fontSize: 70,
                            decoration: TextDecoration.none,
                            color: Color(0xffbfdbf7))),
                    SizedBox(height: 20),
                    Container(
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.blue),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTour()));
                        },
                        child:
                            Text('Thêm Tour', style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff219ebc),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.blue),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditTour()));
                        },
                        child: Text('Sửa Tour', style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff219ebc),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                    ),
                    SizedBox(height: 20),

                    //Tour đã đăng ký
                    Container(
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.blue),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowBillOfUser()));
                        },
                        child: Text('Tour đã đăng ký',
                            style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff219ebc),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                    ),
                    SizedBox(height: 20),

                    //Đăng xuất
                    Container(
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.blue),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntroducePage()),
                            );
                            _signOut();
                          });
                        },
                        child:
                            Text('Đăng xuất', style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff219ebc),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
