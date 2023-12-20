import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SingleChildScrollView(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  color: Colors.grey[700],
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                controller: emailController,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 22, color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  labelText: 'Email',
                  // errorText: !_isValid || _emailInValid
                  //     ? _emailError
                  //     : null,
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: passwordReset,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF5B5B),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22))),
                  padding: const EdgeInsets.all(12)),
              child:
                  Text('Reset', style: GoogleFonts.plusJakartaSans(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
