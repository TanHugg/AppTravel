import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/billTotal.dart';
import 'package:travel_app/values/custom_text.dart';

import '../../model/aTour.dart';
import '../../model/tourDetails.dart';

class ShowBoughtTour extends StatelessWidget {
  const ShowBoughtTour({super.key, required this.bill});

  final billTotal bill;

  //Lấy ra cái Tour nào có thuộc tính truyền vào là nameTour
  Future<aTour?> readTour(String idTour) async {
    final docUser = FirebaseFirestore.instance
        .collection("Tour")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return aTour.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  Future<tourDetails?> readTourDetail(String idTour) async {
    final docTourDetails = FirebaseFirestore.instance
        .collection("TourDetails")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docTourDetails.get();

    if (snapshot.docs.isNotEmpty) {
      return tourDetails.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return FutureBuilder(
      future: readTourDetail(bill.idTour.toString()),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          final tourDetails = snapShot.data;
          return (tourDetails == null)
              ? Center(child: Text('No Find Tour !'))
              : FutureBuilder(
                  future: readTour(bill.idTour.toString()),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      final tour = snapShot.data;
                      return (tour == null)
                          ? Center(child: Text('No Find Tour !'))
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
                                                  backgroundColor:
                                                      Colors.black12,
                                                ),
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .arrowLeftLong,
                                                  size: 33,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 42, left: 12),
                                              child: Text(
                                                'Thông tin Tour',
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
                                                tour.nameTour.toString(),
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
                                              SizedBox(height: 6),
                                              Row(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .locationDot,
                                                    size: 12,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 8),
                                                  CustomText(
                                                    text: tourDetails.placeTour
                                                        .toString(),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.13,
                                                    height: 1.5,
                                                    color: Colors.grey,
                                                  )
                                                ],
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
                                                  text:
                                                      'Ngày khởi hành :  ${tourDetails.startDay}/${tourDetails.startMonth}/${tourDetails.startYear}',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              SizedBox(height: 15),
                                              CustomText(
                                                  text:
                                                      'Giờ khởi hành:  ${tourDetails.timeStart}',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              SizedBox(height: 15),
                                              CustomText(
                                                  text:
                                                      'Số ngày đi:  ${tourDetails.dayEnd} ngày',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              SizedBox(height: 15),
                                              CustomText(
                                                  text:
                                                      'Nơi gặp mặt: Sân bay Tân Sơn Nhất TpHCM',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              SizedBox(height: 15),
                                              CustomText(
                                                  text: tourDetails.hotel
                                                      .toString(),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              SizedBox(height: 15),
                                              CustomText(
                                                  text:
                                                      'Có gì thắc mắc xin liên hệ:',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                  height: 1.8,
                                                  color: Colors.black),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: CustomText(
                                                    text:
                                                        '0919349408 - 0832348888',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.5,
                                                    height: 1.8,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 120,
                                  left: 220,
                                  child: Container(
                                    width: 135,
                                    height: 135,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: Image.asset(
                                          "assets/images/picture_tours/${tourDetails.imageTourDetails}.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                    } else if (snapShot.hasError) {
                      return Center(child: Text('Error: ${snapShot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
        } else if (snapShot.hasError) {
          return Center(child: Text('Error: ${snapShot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
