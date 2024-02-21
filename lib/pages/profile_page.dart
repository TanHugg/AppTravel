import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:travel_app/pages/introduce_page.dart';
import 'package:travel_app/values/custom_text.dart';
import 'package:travel_app/widget/AssistantPage/assistant_page.dart';
import 'package:travel_app/widget/ProfilePage/contact_page.dart';
import 'package:travel_app/widget/ProfilePage/feedback_page.dart';
import 'package:travel_app/widget/ProfilePage/information_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/widget/ProfilePage/processing_page.dart';

import '../model/users.dart';
import '../widget/ProfilePage/Custom_Information/MyClipper.dart';
import '../widget/ProfilePage/profile_menu.dart';
import '../widget/ProfilePage/update_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.users}) : super(key: key);

  final Users users;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String path_to_images;
  late File imagesFile;
  late Image images;

  @override
  void initState() {
    super.initState();
    path_to_images = widget.users.imageUser;
    imagesFile = File(path_to_images);
    images = Image.file(imagesFile);
  }

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
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: SizedBox(
                height: 170,
                width: 170,
                child: ClipOval(
                  child: imagesFile.existsSync()
                      ? Image.file(
                          imagesFile,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        )
                      : Image(
                          image: AssetImage(
                              'assets/images/face_images/Face_1.jpg'),
                          fit: BoxFit.cover,
                        ),
                  clipper: MyClipper(),
                ),
              ),
            ),
            //Tên và Email
            const SizedBox(height: 12),
            AutoSizeText(
              widget.users.nameUser,
              maxFontSize: 37,
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 40, color: Colors.black87),
            ),
            AutoSizeText(
              widget.users.email,
              maxFontSize: 20,
              maxLines: 1,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 27, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            //Nút Edit Profile
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(
                                  users: widget.users,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                  child: const CustomText(
                      text: 'Cài đặt hồ sơ',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      height: 1)),
            ),
            //Settings,BillingDetails,User Management
            const SizedBox(height: 25),
            //Nút Góp ý
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ProfileMenuWidget(
                    title: "Góp ý",
                    icon: LineAwesomeIcons.wallet,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedBackPage(
                                    idUser: widget.users.idUser,
                                  )));
                    });
              },
            ),
            const SizedBox(height: 10),
            //Nút liên hệ
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ProfileMenuWidget(
                    title: "Liên hệ",
                    icon: LineAwesomeIcons.user_check,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactPage()));
                    });
              },
            ),
            const SizedBox(height: 10),
            //Nút Tour đang xử lý
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ProfileMenuWidget(
                    title: "Tour đang xử lý",
                    icon: LineAwesomeIcons.wrench,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProcessingPage(users: widget.users)));
                    });
              },
            ),
            const SizedBox(height: 10),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ProfileMenuWidget(
                    title: "Trợ lý ảo",
                    icon: LineAwesomeIcons.headset,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AssistantPage(users: widget.users)));
                    });
              },
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            //Nút Thông tin cá nhân
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return ProfileMenuWidget(
                    title: "Thông tin cá nhân",
                    icon: LineAwesomeIcons.info,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InformationPage(
                                    user: widget.users,
                                  )));
                    });
              },
            ),

            ProfileMenuWidget(
                title: "Thoát",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.yellow,
                endIcon: false,
                onPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => IntroducePage()),
                  );
                  _signOut();
                }),
          ],
        ),
      ),
    );
  }
}

//ten nè
const String UserNameProfile = "Tan Hung";
const String EmailProfile = "tanhung@gmail.com";
const String EditProfile = "Cập nhật hồ sơ";
const DarkColor = Color(0xff000000);
const PrimaryColor = Color(0xFFFFE400);
const tAccentColor = Color(0xFF001BFF);

const String Menu1 = "Setting";
