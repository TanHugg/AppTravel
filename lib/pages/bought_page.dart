import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/billTotal.dart';
import '../model/users.dart';
import '../widget/CustomBoughtTour/customBoughtTour.dart';

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
        padding: EdgeInsets.only(top: 80, left: 22, right: 22, bottom: 15),
        child: Container(
          width: size.width,
          height: 720,
          child: Column(children: <Widget>[
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
                height: 550,
                width: size.width,
                child: StreamBuilder<List<billTotal>>(
                  stream: readBill(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final billTotal = snapshot.data!;
                      return ListView(
                        children: billTotal.map(buildTour).toList(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ]),
        ),
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
