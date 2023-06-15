import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/pages/profile_page.dart';
import 'package:travel_app/values/custom_text.dart';

import 'Custom_Information/MyClipper.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key, required this.idUser}) : super(key: key);

  final idUser;

  Future updateFavoriteDetails(String idUser, String name, int numberPhone,
      String address) async {
    final docUser = FirebaseFirestore.instance.collection("User").doc(idUser);
    await docUser.update({
      'name': name,
      'numberPhone': numberPhone,
      'address': address,
    });
  }

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  // final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    numberPhoneController.dispose();
    // emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                LineAwesomeIcons.angle_left,
                color: Colors.black,
              )),
        ),
        title:
            Text(EditProfile, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/face_images/Face_1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    clipper: MyClipper(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  QrImageView(
                    data: widget.idUser.toString(),
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person_outline_rounded)),
                  ),
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: const InputDecoration(
                  //       labelText: "Email",
                  //       prefixIcon: Icon(Icons.email_outlined)),
                  // ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: numberPhoneController,
                    decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_android_outlined)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.fingerprint)),
                  ),
                  const SizedBox(height: 35),

                  //Nút Edit Profile
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 200), //Xem lại
                    child: SizedBox(
                        width: 230,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.updateFavoriteDetails(
                                widget.idUser.toString(),
                                fullNameController.text,
                                int.parse(numberPhoneController.text),
                                addressController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Update thành công}")));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffffd500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const CustomText(
                                text: 'Edit',
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                height: 1.3))),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
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
