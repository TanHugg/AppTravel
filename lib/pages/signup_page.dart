import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/users.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = false;

  final fullNameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var _emailError = "Tài khoản không hợp lệ";
  var _passError = "Mật khẩu phải trên 6 ký tự";
  var _numError = "Số điện thoại không hợp lệ";
  var _fullNameError = "Tên không hợp lệ";
  var _addressErr = "Địa chỉ không hợp lệ";

  var _emailInValid = false;
  var _passInValid = false;
  var _addressInValid = false;
  var _fullNameInValid = false;
  var _numberPhoneInValid = false;

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // Widget tree.
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    bool _isValid = true;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/introduce.jpg',
              fit: BoxFit.cover, height: size.height, width: size.width),
          Positioned(
              child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 30, top: 65),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                        backgroundColor: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        Text('Đăng kí',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 50, color: Colors.white)),
                        //FullName
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 30, bottom: 15),
                            child: TextField(
                                controller: fullNameController,
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 22, color: Colors.white),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide: const BorderSide(
                                          color: Colors.white70),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                            color: Colors.white70)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide: const BorderSide(
                                          color: Colors.white70),
                                    ),
                                    labelText: 'Họ và tên',
                                    errorText: _fullNameInValid
                                        ? _fullNameError
                                        : null,
                                    labelStyle: const TextStyle(
                                        color: Colors.white70)))),

                        //NumberPhone
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextField(
                            controller: numberPhoneController,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 22, color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: Colors.white70)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                labelText: 'Số điện thoại',
                                errorText:
                                    _numberPhoneInValid ? _numError : null,
                                labelStyle:
                                    const TextStyle(color: Colors.white70)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        //Address
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextField(
                              controller: addressController,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22, color: Colors.white),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide:
                                        const BorderSide(color: Colors.white70),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide: const BorderSide(
                                          color: Colors.white70)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide:
                                        const BorderSide(color: Colors.white70),
                                  ),
                                  labelText: 'Địa chỉ',
                                  errorText:
                                      _addressInValid ? _addressErr : null,
                                  labelStyle:
                                      const TextStyle(color: Colors.white70))),
                        ),

                        //Email
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextField(
                            controller: emailController,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 22, color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: Colors.white70)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                labelText: 'Email',
                                errorText: _emailInValid ? _emailError : null,
                                labelStyle:
                                    const TextStyle(color: Colors.white70)),
                          ),
                        ),

                        //Password
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: TextField(
                            controller: passwordController,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 22, color: Colors.white),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: Colors.white70)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                      const BorderSide(color: Colors.white70),
                                ),
                                labelText: 'Mật khẩu',
                                errorText: _passInValid ? _passError : null,
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                labelStyle:
                                    const TextStyle(color: Colors.white70)),
                            obscuringCharacter: '*',
                            obscureText: !_obscureText,
                          ),
                        ),

                        //Nút đăng ký
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: SizedBox(
                            width: size.width * 2 / 3,
                            height: size.height * 1 / 17,
                            child: ElevatedButton(
                              onPressed: () {
                                if (fullNameController.text.length < 1) {
                                  _fullNameInValid = true;
                                  _isValid = false;
                                } else {
                                  _fullNameInValid = false;
                                }
                                //Đăng ký user-auth
                                if (!emailController.text.contains("@")) {
                                  _emailInValid = true;
                                  _isValid = false;
                                } else {
                                  _emailInValid = false;
                                }
                                if (numberPhoneController.text.length < 10) {
                                  _numberPhoneInValid = true;
                                  _isValid = false;
                                } else {
                                  _numberPhoneInValid = false;
                                }
                                if (passwordController.text.length < 6) {
                                  _passInValid = true;
                                  _isValid = false;
                                } else {
                                  _passInValid = false;
                                }
                                if (addressController.text.length < 1) {
                                  _addressInValid = true;
                                  _isValid = false;
                                } else {
                                  _addressInValid = false;
                                }

                                if (_isValid) {
                                  //Đăng ký Username,Password vào Firebase Auth
                                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);

                                  //Đăng ký user (Firestore)
                                  final user = Users(
                                    nameUser: fullNameController.text,
                                    numberPhone: int.parse(numberPhoneController.text),
                                    address: addressController.text,
                                    email: emailController.text,
                                    imageUser: '',
                                  );

                                  createUsers(user);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginPage())
                                  );
                                } else {
                                  setState(() {});
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF5B5B),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(22))
                                  )
                              ),
                              child: Text('Đăng kí', style: GoogleFonts.plusJakartaSans(fontSize: 25)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

Future createUsers(Users users) async {
  final docUser = FirebaseFirestore.instance.collection('User').doc();
  users.idUser = docUser.id;

  final json = users.toJson();
  await docUser.set(json);
}

//Do cái InputDecoration này được gọi ra nhiều quá nên viết ra tối ưu hơn
InputDecoration decoration(String labelText) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
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
