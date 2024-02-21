import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/pages/login_page.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      // await FirebaseAuth.instance
      //     .sendPasswordResetEmail(email: emailController.text.trim());
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Hãy kiểm tra Email của bạn!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 30, top: 65),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(18),
                          backgroundColor: Colors.black12,
                        ),
                        child: const Icon(Icons.arrow_back,
                            size: 35, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/icons/appicon.png',
                      height: 250,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Nhập email của bạn vào đây!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: TextField(
                        controller: emailController,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22, color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          labelText: 'Email',
                          // errorText: !_isValid || _emailInValid
                          //     ? _emailError
                          //     : null,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: passwordReset,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF5B5B),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          padding: const EdgeInsets.all(12)),
                      child: Text('Reset',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 23, color: Colors.white)),
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
