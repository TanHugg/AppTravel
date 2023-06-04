import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/billTotal.dart';
import '../model/users.dart';

class BoughtPage extends StatelessWidget {
  const BoughtPage({Key? key, required this.users}) : super(key: key);

  final Users users;

  Stream<List<billTotal>> readBill() => FirebaseFirestore.instance
      .collection('Bill')
      .where('idUser', isEqualTo: users.idUser.toString())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => billTotal.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<billTotal>>(
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
    );
  }

  Widget buildTour(billTotal bill) => ListTile(
        leading: CircleAvatar(child: Text('${bill.idBill}')),
        title: Text(bill.idTour ?? ""),
        subtitle: Text('${bill.priceBill}'),
      );
}
