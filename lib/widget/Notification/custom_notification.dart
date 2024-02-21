import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/aTour.dart';
import '../../model/billTotal.dart';
import '../../model/tourDetails.dart';
import '../../values/custom_text.dart';

import 'package:intl/intl.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({Key? key, required this.bill}) : super(key: key);

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
    // Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    String dateString = bill.dateTime.toString();
    DateTime datetime = DateTime.parse(dateString);
    String formattedDate =
        DateFormat('dd/MM/yyyy   HH:mm', 'vi_VN').format(datetime.toLocal());

    return FutureBuilder(
        future: readTour(bill.idTour.toString()),
        builder: (context, snapshot) {
          final tour = snapshot.data;
          return tour == null
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder(
                  future: readDetailTour(tour.idTour.toString()),
                  builder: (context, snapshot) {
                    final tourDetails = snapshot.data;
                    return tourDetails == null
                        ? Center(child: CircularProgressIndicator())
                        : Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    "assets/images/picture_tours/${tourDetails.imageTourDetails}.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 90,
                                  top: 15,
                                  child: Container(
                                    width: 240,
                                    height: 85,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text:
                                                  'Bạn đã đặt thành công tour: ',
                                              style: GoogleFonts.sen(
                                                  textStyle: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black87)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${tour.nameTour.toString()}',
                                                  style: GoogleFonts.sen(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 21,
                                                              color: Color(
                                                                  0xff01497c),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                )
                                              ]),
                                        ),
                                        CustomText(
                                            text: '${formattedDate}',
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                            height: 2)
                                      ],
                                    ),
                                  )),
                            ],
                          );
                  });
        });
  }
}
