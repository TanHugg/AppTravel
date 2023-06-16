import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import '../model/aTour.dart';
import '../model/favoriteDetails.dart';
import '../model/users.dart';
import '../widget/Details/vacation_details.dart';
import '../widget/HomePage/custom_tours.dart';
import 'package:intl/intl.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key, required this.users}) : super(key: key);

  final Users users;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<aTour> _favoriteTours = [];

  Stream<List<FavoriteDetails>> readFavoriteDetails() =>
      FirebaseFirestore.instance
          .collection('FavoriteDetails')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => FavoriteDetails.fromJson(doc.data()))
              .toList())
          .map((favDetails) {
        // Cập nhật danh sách các aTour yêu thích trong State object
        _favoriteTours = [];
        for (final item in favDetails) {
          readTour(item.idTour.toString()).then((tour) {
            if (tour != null) {
              tour.isFavorite = item.favorite;
              tour.idUser = item.idUser;
              _favoriteTours.add(tour);
            }
          });
        }
        return favDetails;
      });

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

  Future deleteFavoriteDetails(String idUser, String idTour) async {
    final docFavoriteDetails = FirebaseFirestore.instance
        .collection("FavoriteDetails")
        .where('idUser', isEqualTo: idUser)
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docFavoriteDetails.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    // Xóa aTour khỏi danh sách trong State object và rebuild widget tree
    setState(() {
      _favoriteTours.removeWhere((tour) => tour.idTour == idTour);
    });
    CustomSnackbar.show(context, 'Xóa thành công');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Container(
      padding: EdgeInsets.only(top: 20, left: 22, right: 22),
      width: size.width,
      height: 735,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          RichText(
              text: TextSpan(
              text: 'Y',
              style: GoogleFonts.berkshireSwash(
                  fontSize: 72,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffff4d6d)),
              children: <TextSpan>[
                customTextSpan('o', 52, Colors.black87),
                customTextSpan('u', 38, Colors.black87),
                customTextSpan('r', 32, Colors.black87),
                customTextSpan('L', 68, Color(0xffff4d6d)),
                customTextSpan('i', 44, Colors.black87),
                customTextSpan('k', 36, Colors.black87),
                customTextSpan('e', 32, Colors.black87),
              ])),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                  height: 600,
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
                                  tour.idUser = item.idUser;
                                  return GestureDetector(
                                    onTap: () {
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
            ),
          ),
        ],
      ),
    );
  }

  //A Widget FavoriteLike
  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  Widget buildATour(aTour tour, int index, BuildContext context) => Dismissible(
        key: UniqueKey(),
        background: Container(
          decoration: BoxDecoration(
              color: Color(0xffd81159),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: EdgeInsets.only(left: 25, top: 70),
              child: FaIcon(
                FontAwesomeIcons.trashCan,
                size: 55,
                color: Colors.white,
              )),
        ),
        secondaryBackground: Container(color: Colors.red),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            deleteFavoriteDetails(
                tour.idUser.toString(), tour.idTour.toString());
            // Remove the Dismissible widget from the list of favorites.
            setState(() {
              _favoriteTours.removeAt(index);
            });
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
            money: formattedPrice.format(int.parse('${tour.priceTour}')),
          ),
        ),
      );

  //Custom TextSpan
  TextSpan customTextSpan(String text, double size, Color colors) {
    return TextSpan(
        text: text,
        style: GoogleFonts.berkshireSwash(
            fontSize: size, fontWeight: FontWeight.w400, color: colors));
  }
}
