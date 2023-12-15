import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/aTour.dart';
import '../model/users.dart';
import '../widget/HomePage/custom_tours.dart';

import 'package:intl/intl.dart';

const kModelName = "recommendations";

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

  //Lấy ra tất cả tour có trong Firebase thông qua typeTour truyền vô
  Stream<List<aTour>> readListTour() => FirebaseFirestore.instance
      .collection('Tour')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList());

  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('email', isEqualTo: user_auth.email);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    } else {
      throw Exception('No user found with this email');
    }
  }

  late String idUserCurrent;

  @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  FirebaseCustomModel? model;

  /// Initially get the local model if found, and asynchronously get the latest one in background.
  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);

    setState(() {
      model = _model;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20), //Đổi ở đây
        child: Container(
            height: 700, //Đổi ở đây
            width: size.width,
            child: StreamBuilder<List<aTour>>(
              stream: readListTour(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final aTour = snapshot.data;
                  return ListView.builder(
                    itemCount: aTour!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildATour(aTour[index]);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }

  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
  Widget buildATour(aTour tour) => Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hình ảnh
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/picture_tours/${tour.nameTour.toString()}.jpg",
                  fit: BoxFit.cover,
                  width: 120,
                  height: 100,
                ),
              ),

              // Chi tiết tour
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên tour
                  Text(
                    tour.nameTour.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  // Ngày khởi hành
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                    ],
                  ),

                  // Giá tour
                  Text(
                    formattedPrice.format(int.parse('${tour.priceTour}')),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
