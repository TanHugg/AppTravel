import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/widget/Notification/custom_notification.dart';
import '../../model/billTotal.dart';
import '../../values/custom_text.dart';

class BellNotification extends StatelessWidget {
  const BellNotification({Key? key, required this.users}) : super(key: key);

  final String users; //User hiện tại

  Stream<List<billTotal>> readBill() => FirebaseFirestore.instance
      .collection('Bill')
      .where('idUser', isEqualTo: users)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => billTotal.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30, top: 65),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
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
                        FontAwesomeIcons.arrowLeft,
                        size: 30,
                        color: Colors.black87,
                      )),
                ),
                SizedBox(width: 17),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                        text: 'Your',
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        height: 1),
                    CustomText(
                        text: 'Notification',
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        height: 1),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Container(
              width: size.width,
              height: 600,
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
          )
        ],
      ),
    );
  }

  Widget buildTour(billTotal bill) => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
              color: Color(0xffedede9),
              borderRadius: BorderRadius.circular(35)),
          child: CustomNotification(bill: bill),
        ),
      );
}
