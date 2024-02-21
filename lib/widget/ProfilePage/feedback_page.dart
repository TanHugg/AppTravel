import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/values/custom_snackbar.dart';

import '../../model/feedBack.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key, required this.idUser}) : super(key: key);

  final idUser;

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  Future createFeedBack(feedBack feedBack) async {
    final docFeedBack = FirebaseFirestore.instance.collection("FeedBack").doc();
    feedBack.idFeedBack = docFeedBack.id;

    final json = feedBack.toJson();
    await docFeedBack.set(json);
  }

  final contentController = TextEditingController();

  void updateState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    contentController.addListener(updateState);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime dateTimeNow = DateTime.now();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/cover_images/Picture_7.jpg',
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
                child: Container(
                  width: size.width,
                  height: size.width,
                  margin: const EdgeInsets.only(top: 75),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: TextFormField(
                    maxLines: 6,
                    autofocus: false,
                    controller: contentController,
                    style: GoogleFonts.quicksand(
                        fontSize: 26,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: Colors.white70),
                      ),
                      label: Text(
                        'Viết góp ý tại đây',
                        style: TextStyle(
                          color: Colors.white70,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 90,
                left: 123,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: <Widget>[
                      Text('Góp ý',
                          style: GoogleFonts.catamaran(
                              fontSize: 60,
                              color: Colors.white,
                              decoration: TextDecoration.none)),
                    ],
                  ),
                )),
            Positioned(
              top: 550,
              left: 110,
              child: Container(
                width: 190,
                height: 80,
                child: (contentController.text.contains(RegExp(r'[a-zA-Z]')))
                    ? ElevatedButton(
                        onPressed: () {
                          final aFeedBack = feedBack(
                              feedBackContent: contentController.text,
                              dateTimeFeedBack: dateTimeNow.toString(),
                              idUser: widget.idUser);
                          createFeedBack(aFeedBack);
                          Navigator.pop(context);
                          CustomSnackbar.show(context, 'Góp ý thành công!');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF5B5B),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        child: Text('Góp ý',
                            style: GoogleFonts.plusJakartaSans(fontSize: 30, color: Colors.white)),
                      )
                    : ElevatedButton(
                        onPressed: null,
                        child: Text('Góp ý',
                            style: GoogleFonts.plusJakartaSans(fontSize: 30)),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.grey, // Màu chữ trắng
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))))),
              ),
            ),
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
                      child: FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 33,
                        color: Colors.white,
                      )),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
