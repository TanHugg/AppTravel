import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/model/favoriteDetails.dart';
import 'package:travel_app/model/users.dart';
import 'package:travel_app/pages/comment_page.dart';
import 'package:travel_app/pages/flight_ticket.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import 'package:travel_app/values/custom_text.dart';
import 'package:like_button/like_button.dart';
import '../../model/tourDetails.dart';
import 'package:intl/intl.dart';

class VacationDetails extends StatefulWidget {
  const VacationDetails({Key? key, required this.tour, required this.user,}) : super(key: key);
  final aTour tour;
  final Users user;
  @override
  State<VacationDetails> createState() => _VacationDetailsState();
}

class _VacationDetailsState extends State<VacationDetails> {
  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  //Trong đây nó có idUserCurrent
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

  Future createFavoriteDetails(FavoriteDetails favoriteDetails) async {
    final docFavoriteDetails =
        FirebaseFirestore.instance.collection("FavoriteDetails").doc();
    favoriteDetails.idFavoriteDetails = docFavoriteDetails.id;

    final json = favoriteDetails.toJson();
    await docFavoriteDetails.set(json);
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
  }

  // //Lấy thông tin like ra Analytics
  // logAnalytics(String id){
  //   analytics.logEvent(name: )
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return FutureBuilder(
      future: readTourDetail(widget.tour.idTour.toString()),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          final tourDetails = snapShot.data;
          return (tourDetails == null)
              ? Center(
                  child: Text('No Find Tour !'),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      //Images Background
                      width: size.width,
                      height: size.height * 3 / 6,
                      child: Image.asset(
                          "assets/images/picture_tours/${tourDetails.imageTourDetails}.jpg",
                          // child: Image.asset("assets/images/picture_tours/ChinaMounDetails.jpg",
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      //IconBackScreen
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
                    Positioned(
                        //Container name,location,details,...
                        width: size.width,
                        height: 500,
                        top: size.height * 4 / 10,
                        child: Container(
                          //Full WhiteScreen
                          padding: EdgeInsets.only(
                              left: 20, top: 30, right: 20, bottom: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: Colors.white),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: size.width,
                                  child: Row(children: <Widget>[
                                    CustomText(
                                      //Name tour
                                      text: widget.tour.nameTour.toString(),
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.13,
                                      height: 1.3,
                                      color: Colors.black,
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.messenger_rounded,
                                          size: 37,
                                          color: Colors.blueAccent.shade200,
                                        ),
                                        onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentPage(
                                            tour: widget.tour, tourDetails: tourDetails, users: widget.user,)))
                                      ),
                                    ),
                                    Padding(
                                      //Favorite
                                      padding: EdgeInsets.only(right: 20),
                                      child: LikeButton(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        isLiked:
                                            widget.tour.isFavorite ?? false,
                                        onTap: (bool isLiked) async {
                                          setState(() {
                                            widget.tour.isFavorite = !isLiked;
                                          });
                                          FavoriteDetails favorite;
                                          setState(() {
                                            (widget.tour.isFavorite == true)
                                                ? {
                                                    favorite = FavoriteDetails(
                                                        idUser:
                                                            widget.tour.idUser,
                                                        idTour:
                                                            widget.tour.idTour,
                                                        favorite: widget
                                                            .tour.isFavorite),
                                                    createFavoriteDetails(
                                                        favorite),
                                                    analytics
                                                        .setAnalyticsCollectionEnabled(
                                                            true),
                                                    analytics.logEvent(
                                                        name: 'isFavorite',
                                                        parameters: <String,
                                                            dynamic>{
                                                          'idTour': widget
                                                              .tour.idTour,
                                                          'nameTour': widget
                                                              .tour.nameTour,
                                                          'priceTour': widget
                                                              .tour.priceTour,
                                                          'typeTour': widget
                                                              .tour.typeTour
                                                        }),
                                                    CustomSnackbar.show(context,
                                                        'Thêm vào danh sách yêu thích thành công'),
                                                  }
                                                : {
                                                    deleteFavoriteDetails(
                                                        widget.tour.idUser
                                                            .toString(),
                                                        widget.tour.idTour
                                                            .toString()),
                                                    CustomSnackbar.show(context,
                                                        'Xóa khỏi danh sách yêu thích thành công'),
                                                  };
                                            //Mở Firebase ra lưu vào IdUser, IdTour, và trạng thái lúc này là true
                                          });
                                          return widget.tour.isFavorite ??
                                              false;
                                        },
                                        size: 35,
                                        circleColor: CircleColor(
                                            start: Color(0xff00ddff),
                                            end: Color(0xff0099cc)),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: Color(0xff33b5e5),
                                          dotSecondaryColor: Color(0xff0099cc),
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: isLiked
                                                ? Colors.pink
                                                : Colors.grey,
                                            size: 35,
                                          );
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    CustomText(
                                      text: tourDetails.placeTour.toString(),
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
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.10,
                                    height: 1.5,
                                    color: Colors.black87),
                                SizedBox(height: 15),
                                CustomText(
                                    text:
                                        'Ngày khởi hành :  ${tourDetails.startDay}/${tourDetails.startMonth}/${tourDetails.startYear}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 15),
                                CustomText(
                                    text:
                                        'Giờ khởi hành:  ${tourDetails.timeStart}',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 15),
                                CustomText(
                                    text:
                                        'Số ngày đi:  ${tourDetails.dayEnd} ngày',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 15),
                                CustomText(
                                    text:
                                        'Nơi gặp mặt: Sân bay Tân Sơn Nhất TpHCM',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 15),
                                CustomText(
                                    text: tourDetails.hotel.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 15),
                                CustomText(
                                    text: 'Mô tả:',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                CustomText(
                                    text: tourDetails.description.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    height: 1.8,
                                    color: Colors.black),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text.rich(TextSpan(
                                        text: formattedPrice.format(int.parse(
                                            '${widget.tour.priceTour}')),
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 16,
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '/',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontSize: 20,
                                                decoration: TextDecoration.none,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              )),
                                          TextSpan(
                                              text: 'Person',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontSize: 16,
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1))
                                        ])),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FlightTicket(
                                                        tour: widget.tour,
                                                        tourDetail: tourDetails,
                                                        //Chuyển thêm cái id nữa
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.pink,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(11),
                                          child: CustomText(
                                              text: 'Đặt',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              height: 0,
                                              color: Colors.white),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
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
