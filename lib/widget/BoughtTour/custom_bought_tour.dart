import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/model/billTotal.dart';
import 'package:travel_app/model/tourDetails.dart';
import 'package:travel_app/values/custom_text.dart';

import '../../model/aTour.dart';
import 'package:intl/intl.dart';

class CustomBoughtTour extends StatelessWidget {
  const CustomBoughtTour({Key? key, required this.bill}) : super(key: key);

  final billTotal bill;

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
    final formattedPrice = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return FutureBuilder(
        future: readTour(bill.idTour.toString()),
        builder: (context, snapshot) {
          final tour = snapshot.data;
          return tour == null
              ? Center(child: Text('No find Tour!'))
              : FutureBuilder(
              future: readDetailTour(tour.idTour.toString()),
              builder: (context, snapshot) {
                final tourDetails = snapshot.data;
                return tourDetails == null
                    ? Center(child: Text('No find Tour!'))
                    : Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: 100,
                        height: 140,
                        child: Image.asset(
                          "assets/images/picture_tours/${tourDetails.imageTourDetails}.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        left: 120,
                        top: 15,
                        child: CustomText(
                            text: tour.nameTour.toString(),
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            height: 1)),
                    Positioned(
                      left: 120,
                      top: 40,
                      child: Row(
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.locationDot,
                              size: 20, color: Color(0xff6c757d)),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: CustomText(
                                text:
                                tourDetails.placeTour.toString(),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.5,
                                height: 0,
                                color: Color(0xff6c757d)),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        left: 120,
                        top: 68,
                        child: FaIcon(
                          FontAwesomeIcons.calendarDay,
                          size: 21,
                        )),
                    Positioned(
                        left: 145,
                        top: 71,
                        child: CustomText(
                            text:
                            '${tourDetails.startDay}/${tourDetails.startMonth} '
                                '- ${tourDetails.dayEnd}/${tourDetails.startMonth}',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            height: 1)),
                    Positioned(
                        left: 206,
                        top: 100,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: Color(0xffef233c)),
                          child: CustomText(
                              text: formattedPrice.format(int.parse(
                                  tour.priceTour.toString())),
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              height: 1),
                        ))
                  ],
                );
              });
        });
  }
}
