import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/BoughtTour/custom_bought_tour.dart';
import 'package:travel_app/widget/BoughtTour/show_bought_tour.dart';
import '../model/billTotal.dart';
import '../model/users.dart';

class BoughtPage extends StatelessWidget {
  const BoughtPage({Key? key, required this.users}) : super(key: key);

  final Users users; //User hiện tại

  Stream<List<billTotal>> readBill() => FirebaseFirestore.instance
      .collection('Bill')
      .where('idUser', isEqualTo: users.idUser.toString())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => billTotal.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: Padding(
        // padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 15),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(children: <Widget>[
          Positioned(
            left: 10,
            bottom: 430,
            right: 15,
            child: ClipRRect(
              child: SizedBox(
                width: 350,
                height: 270,
                child: Image.asset(
                  "assets/images/nobackground/CoconutTree.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 187),
            child: Container(
              width: size.width,
              height: 515,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(TextSpan(
                        text: 'Bought',
                        style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Tour',
                              style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Colors.black87))
                        ])),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        height: 447,
                        width: size.width,
                        child: StreamBuilder<List<billTotal>>(
                          stream: readBill(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<billTotal>> snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong! ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final billTotal = snapshot.data!;
                              return ListView.builder(
                                itemCount: billTotal.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowBoughtTour(
                                              billTotal: billTotal[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: buildTour(billTotal[index]),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildTour(billTotal bill) => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffedede9),
              borderRadius: BorderRadius.circular(20)),
          child: CustomBoughtTour(bill: bill),
        ),
      );
}
