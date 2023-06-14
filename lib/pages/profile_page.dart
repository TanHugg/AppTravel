import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:travel_app/widget/ProfilePage/update_profile_screen.dart';
import 'package:travel_app/values/custom_text.dart';
import 'package:travel_app/widget/ProfilePage/contact_page.dart';
import 'package:travel_app/widget/ProfilePage/feedback_page.dart';
import 'package:travel_app/widget/ProfilePage/information_page.dart';
import '../model/users.dart';
import '../widget/ProfilePage/profile_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.users}) : super(key: key);

  final Users users;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //Hàm Logout
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              (image != null) //Avata
                  ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )
                  : FlutterLogo(size: 130),
              Positioned(
                  //Camera
                  bottom: 0,
                  right: 65,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()));
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 26,
                    ),
                  )),
            ]),
            //Tên và Email
            const SizedBox(height: 12),
            Text(widget.users.nameUser,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 40, color: Colors.black87)),
            Text(widget.users.email,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 20, color: Colors.black87)),
            const SizedBox(height: 20),
            //Nút Edit Profile
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                  child: const CustomText(
                      text: 'Edit Profile',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      height: 1)),
            ),
            //Settings,BillingDetails,User Management
            const SizedBox(height: 25),
            ProfileMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog,
                onPress: () {
                  print("DA NHAN VAO Settings");
                }),
            const SizedBox(height: 10),
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
                  Navigator.of(context).pop();
                  _signOut();
                }),
          ],
        ),
      ),
    );
  }

  @override
//POPUP LUC NHAN THAY DOI AVA
  Widget bottomSheet() {
    void takePhoto(ImageSource source) async {
      // // ignore: deprecated_member_use
      // final pickedFile = await _picker.getImage(
      //   source: source,
      // );
      // setState((){
      //   _imageFile= pickedFile!;
      // });
    }
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo from",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                  // takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//KHAI BÁO CHO TIỆN DUNG
const String Profile = "Profile";
const String ProfileImage = "assets/images/picture_tours/Colosseum.jpg";
//ten nè
const String UserNameProfile = "Tan Hung";
const String EmailProfile = "tanhung@gmail.com";
const String EditProfile = "Edit Profile";
const DarkColor = Color(0xff000000);
const PrimaryColor = Color(0xFFFFE400);
const tAccentColor = Color(0xFF001BFF);

const String Menu1 = "Setting";
