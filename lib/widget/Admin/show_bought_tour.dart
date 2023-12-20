import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/billTotal.dart';
import 'package:travel_app/widget/Admin/widget/custom_show_bill.dart';

import '../BoughtTour/custom_bought_tour.dart';

class ShowBillOfUser extends StatelessWidget {
  const ShowBillOfUser({Key? key}) : super(key: key);

  Stream<List<billTotal>> readBill() => FirebaseFirestore.instance
      .collection('Bill')
      .where('checkBought', isEqualTo: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => billTotal.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        // padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 15),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(children: <Widget>[
          Positioned(
            //IconBackScreen
            top: 15,
            child: Row(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12, top: 65),
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
              Padding(
                padding: EdgeInsets.only(top: 60, left: 5),
                child: Text.rich(TextSpan(
                    text: 'Tour',
                    style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' đang xử lý',
                          style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Colors.black87))
                    ])),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 147),
            child: Container(
              width: size.width,
              height: 600,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        height: 570,
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
                                                CustomShowBillOfUser(
                                                    bill: billTotal[index]),
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
