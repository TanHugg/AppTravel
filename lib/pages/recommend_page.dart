import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/users.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key, required this.users});

  final Users users;

  // //Lấy ra cái Tour nào có thuộc tính truyền vào là nameTour
  // Future<aTour?> readTour(String nameTour) async {
  //   final docUser = FirebaseFirestore.instance
  //       .collection("Tour")
  //       .where('nameTour', isEqualTo: nameTour);
  //   final snapshot = await docUser.get();
  //
  //   if (snapshot.docs.isNotEmpty) {
  //     return aTour.fromJson(snapshot.docs.first.data());
  //   }
  //   return null;
  // }
  //
  // //Lấy ra tất cả tour có trong Firebase thông qua typeTour truyền vô
  // Stream<List<aTour>> readListTour(String typeTour, String searchTour) =>
  //     (typeTour == '')
  //         ? FirebaseFirestore.instance
  //         .collection('Tour')
  //         .where('nameTour', isGreaterThanOrEqualTo: searchTour)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //         .map((doc) => aTour.fromJson(doc.data()))
  //         .toList())
  //         : FirebaseFirestore.instance
  //         .collection('Tour')
  //         .where('typeTour', isEqualTo: typeTour)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //         .map((doc) => aTour.fromJson(doc.data()))
  //         .toList());

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final user_auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
