import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Custom_Information/MyClipper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Image.asset('assets/images/cover_images/Picture_6.jpg',
            fit: BoxFit.cover, height: size.height, width: size.width),
        Positioned(
            top: 170,
            bottom: 150,
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
                        width: size.width,
                        height: 270,
                        margin: const EdgeInsets.only(top: 65),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Text.rich(TextSpan(
                            text: 'Xin chào!',
                            style: GoogleFonts.openSans(
                                fontSize: 27,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                            children: <TextSpan>[
                              TextSpan(
                                text: '  Cảm ơn bạn đã đồng hành'
                                    ' cùng chúng tôi trong các chuyến đi'
                                    ' nếu có gì thắc mắc xin liên hệ chúng tôi.',
                                style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: '\n\nPhone: 0919349408 - 0254669999'
                                    '\nEmail: summertourist@gmail.com',
                                style: GoogleFonts.openSans(
                                    fontSize: 21,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]))),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.only(left: 45),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                Uri _url = Uri.parse('https://flutter.dev'); // Thay đổi đường dẫn tới Facebook tại đây
                                if (await canLaunchUrl(_url)) {
                                  await launchUrl(_url);
                                } else {
                                  throw 'Không thể mở $_url';
                                }
                              },
                              child: SizedBox(
                                height: 95,width: 95,
                                child: ClipOval(
                                  child: Image(
                                    image:AssetImage(
                                        'assets/images/nobackground/insta.png'),fit: BoxFit.cover,
                                  ),
                                  clipper: MyClipper(),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: (){
                                print('Facebook');
                              },
                              child: SizedBox(
                                height: size.height,width: 80,
                                child: ClipOval(
                                  child: Image(
                                    image:AssetImage(
                                        'assets/images/nobackground/facebook.jpg'),fit: BoxFit.cover,
                                  ),
                                  clipper: MyClipper(),
                                ),
                              ),
                            ),
                            SizedBox(width: 26),
                            GestureDetector(
                              onTap: (){
                                print('Twitter');
                              },
                              child: SizedBox(
                                height: size.height,width: 80,
                                child: ClipOval(
                                  child: Image(
                                    image:AssetImage(
                                        'assets/images/nobackground/tweeter.jpg'),fit: BoxFit.cover,
                                  ),
                                  clipper: MyClipper(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        Positioned(
            top: 90,
            left: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  Text('Contact',
                      style: GoogleFonts.catamaran(
                          fontSize: 60,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                ],
              ),
            )),
        Positioned(
          top: 15,
          child: Row(children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 22, top: 65),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: Colors.black12,
                  ),
                  child: FaIcon(FontAwesomeIcons.arrowLeftLong,size: 33,color: Colors.white,)
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
