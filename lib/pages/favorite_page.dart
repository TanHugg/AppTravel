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
    return Container(
      padding: EdgeInsets.only(top: 80, left: 22, right: 22, bottom: 15),
      width: size.width,
      height: 720,
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
                height: 570,
                width: size.width,
                child: StreamBuilder<List<FavoriteDetails>>(
                  stream: readFavoriteDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final favDetails = snapshot.data;
                      return ListView.builder(
                        itemCount: favDetails?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = favDetails![index];
                          return FutureBuilder<aTour?>(
                            future: readTour(item.idTour.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                aTour tour = snapshot.data!;
                                tour.isFavorite = item.favorite;
                                return GestureDetector(
                                  onTap: () {
                                    print(
                                        'Bạn đã bấm vào phần tử: ${item.idTour}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VacationDetails(tour: tour),
                                      ),
                                    );
                                  },
                                  child: buildATour(tour, index, context),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          );
                        },
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

  Widget buildATour(aTour tour, int index, BuildContext context) => Dismissible(
        key: Key(index.toString()),
        background: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete_forever,size: 80),
          ),
          color: Colors.red,
        ),
        secondaryBackground: Container(color: Colors.red),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Xóa thành công")));
          }
        },
        child: Padding(
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
        ),
      );
}
