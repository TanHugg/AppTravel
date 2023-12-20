import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/Admin/edit_details_tour.dart';

import '../../model/aTour.dart';
import 'package:intl/intl.dart';

import '../HomePage/custom_tours.dart';

class EditTour extends StatefulWidget {
  const EditTour({super.key});

  @override
  State<EditTour> createState() => _EditTourState();

  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  //Lấy ra tất cả tour có trong Firebase thông qua typeTour truyền vô
  Stream<List<aTour>> readListTour() => FirebaseFirestore.instance
      .collection('Tour')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList());
}

class _EditTourState extends State<EditTour> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 22,top: 30,right: 22),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12, top: 35),
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
                      color: Color(0xff00b4d8),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 40),
                child: Text('Sửa Tour',
                    style: GoogleFonts.lato(
                        fontSize: 50,
                        decoration: TextDecoration.none,
                        color: Colors.black87)),
              ),
            ]),
            SizedBox(height: 20),
            Container(
                height: 680,
                width: size.width,
                child: StreamBuilder<List<aTour>>(
                  stream: widget.readListTour(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final aTour = snapshot.data;
                      return ListView.builder(
                        itemCount: aTour!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditDetailsTour()));
                            },
                            child: buildATour(aTour[index]),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
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
          money: EditTour.formattedPrice.format(int.parse('${tour.priceTour}')),
        ),
      );
}
