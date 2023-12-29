import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/pages/admin_page.dart';
import 'package:travel_app/pages/forgetPass.dart';
import 'package:travel_app/pages/main_page.dart';
import 'package:travel_app/pages/signup_page.dart';
import 'package:travel_app/services/auth_services.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/users.dart';
import '../widget/Login/my_forget_password_button.dart';
import '../widget/Login/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = false;

  //Login Function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("loggedIn", true);
      if (user?.email != 'admin@gmail.com') {
        prefs.setBool("User", true);
      } else
        prefs.setBool("User", false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        CustomSnackbar.show(context, 'Email hoặc Mật khẩu không đúng!');
        print("No user found for that email");
      }
    }
    return user;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var _emailError = "Tài khoản không hợp lệ";
  var _passError = "Mật khẩu phải có trên 6 ký tự";
  var _emailInValid = false;
  var _passInValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // Widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            ),
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
                        color: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Text('Đăng Nhập',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 50, color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 40),
                          //ĐIỀN EMAIL (LOGIN)
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
                                  borderSide:
                                      const BorderSide(color: Colors.white70)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: Colors.white70),
                              ),
                              labelText: 'Email',
                              errorText: !_isValid || _emailInValid
                                  ? _emailError
                                  : null,
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          //ĐIỀN PASSWORD
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
                                labelStyle:
                                    const TextStyle(color: Colors.white70),
                                //BẬT / TẮT HIỂN THỊ MẬT KHẨU
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )),
                            obscuringCharacter: '*',
                            obscureText: !_obscureText,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: _forgotPassword,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Button đăng nhập
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: SizedBox(
                            width: size.width * 2 / 3,
                            height: size.height * 1 / 17,
                            //NÚT  LOGIN
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!emailController.text.contains("@")) {
                                  _emailInValid = true;
                                  _isValid = false;
                                } else {
                                  _emailInValid = false;
                                }
                                if (passwordController.text.length < 6) {
                                  _passInValid = true;
                                  _isValid = false;
                                } else {
                                  _passInValid = false;
                                }

                                //Kiểm tra -> đăng nhập
                                if (_isValid) {
                                  User? user = await loginUsingEmailPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);

                                  if (user != null &&
                                      user.email != 'admin@gmail.com') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPage()));
                                  } else if (user!.email == 'admin@gmail.com') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminPage()));
                                  }
                                } else {
                                  setState(() {});
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF5B5B),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22)))),
                              child: Text('Đăng Nhập',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 25, color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'Or continue with',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareTile(
                                onTap: () {},
                                imagePath: 'assets/icons/facebook.png'),
                            SizedBox(width: 25),
                            SquareTile(
                                onTap: () {
                                  AuthService().signInWithGoogle();
                                  FirebaseAuth.instance
                                      .authStateChanges()
                                      .listen((user) async {
                                    if (user != null) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("loggedIn", true);
                                      print(user.email); // Print the email
                                      final userGoogle = Users(
                                        nameUser: user.displayName.toString(),
                                        numberPhone: 0,
                                        address: '',
                                        email: user.email.toString(),
                                        imageUser: user.photoURL.toString(),
                                      );
                                      createUsers(userGoogle);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MainPage()));
                                    } else {
                                      print('No find User!!!!!!!!!!!!!!!!! ');
                                    }
                                  });
                                  // String email = AuthService().signInWithGoogle().then((user) => user.email).catchError((error) {
                                  //   print(error);
                                  // });
                                  // final user = Users(
                                  //   nameUser: '',
                                  //   numberPhone: int.parse(''),
                                  //   address: '',
                                  //   email: email,
                                  //   imageUser: '',
                                  // );
                                  // createUsers(user);
                                  // if(email.toString().length != 0){
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //           const MainPage()));
                                  // }
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //           const MainPage()));
                                },
                                imagePath: 'assets/icons/google.png')
                          ],
                        ),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Chưa có tài khoản ? ',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              //NÚT TẠO TÀI khoản
                              TextSpan(
                                text: ' Tạo ngay !',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()));
                                  },
                              ),
                            ],
                          ),
                        )
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

  Future<void> _forgotPassword() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chọn phương thức reset!",
                style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 30.0),
            MyForgetPasswordButton(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgetPassPage()));
              },
              title: "Email",
              subTitle: "Reset via E-Mail Verification.",
              btnIcon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: 20.0),
            MyForgetPasswordButton(
              onTap: () {},
              title: "Phone No",
              subTitle: "Reset via Phone Verification.",
              btnIcon: Icons.mobile_friendly_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

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
    labelStyle: const TextStyle(color: Colors.white70),
  );
}
