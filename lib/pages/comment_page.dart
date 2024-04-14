import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/model/aComment.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/values/custom_text.dart';
import '../../model/tourDetails.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.tour}) : super(key: key);
  final aTour tour;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

late final aComment Comment;

class _CommentPageState extends State<CommentPage> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  final ScrollController _controller = ScrollController();

  //Trong đây nó có idUserCurrent
  Future<tourDetails?> readTourDetail(String idTour) async {
    final docTourDetails = FirebaseFirestore.instance
        .collection("Comment")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docTourDetails.get();

    if (snapshot.docs.isNotEmpty) {
      return tourDetails.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  Stream<List<aComment>> readListComment(String? idTour) => FirebaseFirestore
      .instance
      .collection('Comment')
      .where('idTour', isGreaterThanOrEqualTo: idTour)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => aComment.fromJson(doc.data())).toList());

  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

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
                                Container(
                                    height: 800, //Đổi ở đây
                                    width: size.width,
                                    child: StreamBuilder<List<aComment>>(
                                        stream:
                                            readListComment(widget.tour.idTour),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Something went wrong! ${snapshot.error}');
                                          } else if (snapshot.hasData) {
                                            final aComment = snapshot.data;
                                            return ListView.builder(
                                              itemCount: aComment!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  isThreeLine: true,
                                                  leading: CircleAvatar(
                                                    child: Text(aComment[index].nameUser!.substring(0, 1)),
                                                  ),
                                                  title: Text(
                                                      aComment[index].nameUser!),
                                                  subtitle: Text(
                                                      aComment[index].comment!),
                                                );
                                              },
                                            );
                                          } else {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        })),
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
