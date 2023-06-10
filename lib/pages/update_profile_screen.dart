import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:travel_app/pages/profile_page.dart';
class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final numberPhoneController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(LineAwesomeIcons.angle_left,color: Colors.black,)),
          ),
          title: Text(EditProfile,style: Theme.of(context).textTheme.headlineSmall),
        ),
      body: SingleChildScrollView(

        child: Container(
          padding: const EdgeInsets.all(DefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  //AVATAR
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image(image: AssetImage("assets/images/picture_tours/Colosseum.jpg"))),
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
                        child: Icon(LineAwesomeIcons.camera,size:20, color: Colors.black)),
                  )

                ],
              ),
              const SizedBox(height: 20),
              Form(child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText:  "Full Name",
                      prefixIcon:Icon(Icons.person_outline_rounded)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText:  "Email",
                        prefixIcon:Icon(Icons.email_outlined)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText:  "Phone No",
                        prefixIcon:Icon(Icons.phone_android_outlined)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText:  "Password",
                        prefixIcon:Icon(Icons.fingerprint)),
                  ),
                  const SizedBox(height: 35),
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
                ],
              ))
            ],
          ),
        ),
      )
    );
  }
}

InputDecoration decoration(String labelText) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white70)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white70));
}


