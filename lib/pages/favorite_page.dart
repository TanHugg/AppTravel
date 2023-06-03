import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/aTour.dart';
import '../model/favoriteDetails.dart';
import '../widget/Details/vacation_details.dart';
import '../widget/HomePage/custom_tours.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  Stream<List<FavoriteDetails>> readFavoriteDetails() =>
      FirebaseFirestore.instance.collection('FavoriteDetails').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => FavoriteDetails.fromJson(doc.data()))
              .toList());

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(
                text: 'Your',
                style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Likes',
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          color: Colors.black87))
                ])),
            Container(
                height: size.width,
                width: size.width,
                child: StreamBuilder<List<FavoriteDetails>>(
                  stream: readFavoriteDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final favDetails = snapshot.data;
                      return ListView(
                        children: favDetails!.map((item) {
                          return FutureBuilder(
                              future: readTour(item.idTour.toString()),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  return (tour == null)
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            print(
                                                // Xử lý sự kiện khi bấm vào phần tử
                                                'Bạn đã bấm vào phần tử: ${item.idTour}');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VacationDetails(
                                                            tour: tour)));
                                          },
                                          child: buildATour(tour),
                                        );
                                } else if (snapShot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget buildATour(aTour tour) => Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: CustomATours(
          nameImage: '${tour.nameTour.toString()}',
          nameTour: '${tour.nameTour.toString()}',
          startDay: tour.startDay!,
          startMonth: tour.startMonth!,
          startYear: tour.startYear!,
          widSizeBox: 360,
          heiSizeBox: 170,
          widContain: 70,
          heiContain: 30,
          money: '\$ ${tour.priceTour}',
        ),
      );
}
