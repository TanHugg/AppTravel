import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:travel_app/pages/update_profile_screen.dart';
import '../model/users.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.users}) : super(key: key);

  final Users users; //User hiện tại

  @override
  Widget build(BuildContext context) {

    var isDark= MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(onPressed: (){},icon: const Icon(LineAwesomeIcons.angle_left)),
      //   title: Text(Profile,style: Theme.of(context).textTheme.headlineSmall),
      //
      //
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(DefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
                    //AVATAR
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image(image: AssetImage(ProfileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: 35,height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: PrimaryColor,
                        ),
                        //CAY BUT CHI`
                        child: Icon(LineAwesomeIcons.alternate_pencil,size:20, color: Colors.black)),
                  )

                ],
              ),
              const SizedBox(height: 10),
              Text(UserNameProfile,style: GoogleFonts.plusJakartaSans(fontSize: 40,color: Colors.black87)),
              Text(EmailProfile,style: GoogleFonts.plusJakartaSans(fontSize: 20,color: Colors.black87)),
              const SizedBox(height: 20),
              //NUT EDIT PROFILE
              SizedBox(width: 200,
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
                  },
                      style:ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor,side: BorderSide.none,shape:StadiumBorder()),
                      child: const Text(EditProfile,style: TextStyle(color: DarkColor)),
                      ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //Mấy cái nút trong profile
              ProfileMenuWidget(title: "Settings",icon:LineAwesomeIcons.cog,onPress: (){
                print("DA NHAN VAO Settings");
              }),
              ProfileMenuWidget(title: "Billing Details",icon:LineAwesomeIcons.wallet,onPress: (){
                print("DA NHAN VAO Billing Details");
              }),
              ProfileMenuWidget(title: "User Management",icon:LineAwesomeIcons.user_check,onPress: (){
                  print("DA NHAN VAO User Management");
              }),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information",icon:LineAwesomeIcons.info,onPress: (){
                print("DA NHAN VAO Informationt");
              }),
              ProfileMenuWidget(title: "Logout",icon:LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.yellow,
                  endIcon: false,
                  onPress: (){
                    Navigator.of(context).pop();
                    _signOut();
                  }),
            ],
          ),
        ),

      )
    );
  }
  //HAM LOGOUT
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    // super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon=true,
    this.textColor,
  }):super(key:key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tAccentColor.withOpacity(0.1),
        ),
        child: Icon(icon,color: tAccentColor),
      ),
      title: Text(title,style: GoogleFonts.plusJakartaSans(fontSize: 20)),
      trailing: endIcon? Container(
          width: 30,height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Icon(LineAwesomeIcons.angle_right,size:18.0, color: Colors.grey)):null
    );
  }
}
//KHAI BÁO CHO TIỆN DUNG
const String Profile="Profile";
const DefaultSize = 30.0;
const String ProfileImage="assets/images/picture_tours/Colosseum.jpg";
//ten nè
const String UserNameProfile="Tan Hung";
const String EmailProfile="tanhung@gmail.com";
const String EditProfile="Edit Profile";
const DarkColor = Color(0xff000000);
const PrimaryColor = Color(0xFFFFE400);
const tAccentColor = Color(0xFF001BFF);

const String Menu1 = "Setting";



