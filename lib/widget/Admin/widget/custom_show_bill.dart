import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/billTotal.dart';
import 'package:travel_app/model/tourDetails.dart';
import 'package:travel_app/values/custom_text.dart';

import '../../../model/aTour.dart';
import '../../../model/users.dart';

class CustomShowBillOfUser extends StatefulWidget {
  const CustomShowBillOfUser({Key? key, required this.bill}) : super(key: key);

  final billTotal bill;

  @override
  State<CustomShowBillOfUser> createState() => _CustomShowBillOfUserState();
}

class _CustomShowBillOfUserState extends State<CustomShowBillOfUser> {
  Future<aTour?> readTour(String idTour) async {
    final docTour = FirebaseFirestore.instance
        .collection("Tour")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docTour.get();

    if (snapshot.docs.isNotEmpty) {
      return aTour.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('id', isEqualTo: widget.bill.idUser);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    } else {
      throw Exception('No user found with this email');
    }
  }

  Future<tourDetails?> readDetailTour(String idTour) async {
    final docDetailTour = FirebaseFirestore.instance
        .collection("TourDetails")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docDetailTour.get();

    if (snapshot.docs.isNotEmpty) {
      return tourDetails.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: readTour(widget.bill.idTour.toString()),
        builder: (context, snapshot) {
          final tour = snapshot.data;
          return tour == null
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  future: readUsers(),
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    return user == null
                        ? Center(child: CircularProgressIndicator())
                        : Stack(
                            children: <Widget>[
                              Container(
                                width: size.width,
                                height: size.height,
                                color: Color(0xffE6E8EC),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          //Go back
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 22, top: 65),
                                          child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(14),
                                                backgroundColor: Colors.black12,
                                              ),
                                              child: FaIcon(
                                                FontAwesomeIcons.arrowLeftLong,
                                                size: 33,
                                                color: Colors.white,
                                              )),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 62, left: 12),
                                            child: Text(
                                              'Tour đã mua',
                                              style: GoogleFonts.hindMadurai(
                                                  fontSize: 38,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.none),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 30),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22, vertical: 22),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        width: size.width,
                                        height: size.height * 2 / 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AutoSizeText(
                                              'Tour: ${tour.nameTour.toString()}',
                                              maxFontSize: 28,
                                              maxLines: 1,
                                              style: GoogleFonts.hindMadurai(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0,
                                                  height: 0,
                                                  color: Colors.black87,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            SizedBox(height: 22),
                                            CustomText(
                                                text: 'Chi tiết',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.10,
                                                height: 1.5,
                                                color: Colors.black87),
                                            SizedBox(height: 15),
                                            CustomText(
                                                text: 'Tên: ${user.nameUser}',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                height: 1.8,
                                                color: Colors.black),
                                            SizedBox(height: 15),
                                            CustomText(
                                                text:
                                                    'Điện thoại: 0${user.numberPhone.toString()}',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                height: 1.8,
                                                color: Colors.black),
                                            SizedBox(height: 15),
                                            CustomText(
                                                text:
                                                    'Địa chỉ: ${user.address}',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.5,
                                                height: 1.8,
                                                color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                  });
        });
  }
}
