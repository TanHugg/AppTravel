
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../model/aTour.dart';
import '../model/users.dart';
import '../widget/Details/vacation_details.dart';
import '../widget/HomePage/custom_tours.dart';

import 'package:intl/intl.dart';

const kModelName = "recommendations";

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key, required this.users});

  final Users users;

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
  List<aTour> _favoriteTours = [];
  final user_auth = FirebaseAuth.instance.currentUser!;

  //Lấy ra tất cả tour có trong Firebase thông qua typeTour truyền vô
  Stream<List<aTour>> readListTour() => FirebaseFirestore.instance
      .collection('Tour')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList());

  //Lấy ra cái Tour nào có thuộc tính truyền vào là nameTour
  Future<aTour?> readTour(String nameTour) async {
    final docUser = FirebaseFirestore.instance
        .collection("Tour")
        .where('nameTour', isEqualTo: nameTour);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return aTour.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

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

  Stream<List<aTour>> readFavoriteDetails() => FirebaseFirestore.instance
          .collection('FavoriteDetails')
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList())
          .map((favDetails) {
        // Cập nhật danh sách các aTour yêu thích trong State object
        _favoriteTours = [];
        for (final item in favDetails) {
          readTour(item.idTour.toString()).then((tour) {
            if (tour != null) {
              tour.isFavorite = item.isFavorite;
              tour.idUser = item.idUser;
              _favoriteTours.add(tour);
            }
          });
        }
        return favDetails;
      });

  late String idUserCurrent;

  @override
  void initState() {
    super.initState();
    initWithLocalModel();
  }

  FirebaseCustomModel? model;
  late Interpreter _interpreter;

  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
        kModelName, FirebaseModelDownloadType.localModelUpdateInBackground);
    _interpreter = await Interpreter.fromFile(_model.file);
    setState(() {
      model = _model;
    });
  }

  Future<List<aTour>> runInference() async {
    final input = readFavoriteDetails();
    final output = <aTour>[];
    _interpreter.run(input, output);
    return output;
  }
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20), //Đổi ở đây
        child: Container(
            height: 800, //Đổi ở đây
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VacationDetails(
                                      tour: aTour[index], user: widget.users,)));
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
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
  //   return Scaffold(
  //     body: Padding(
  //       padding: EdgeInsets.only(top: 60, left: 20, right: 20), //Đổi ở đây
  //       child: Container(
  //           height: 800, //Đổi ở đây
  //           width: size.width,
  //           child: FutureBuilder<List<aTour>>(
  //             future: runInference(),
  //             builder: (context, snapshot) {
  //               if (snapshot.hasError) {
  //                 return Text('Something went wrong! ${snapshot.error}');
  //               } else if (snapshot.hasData) {
  //                 final aTour = snapshot.data;
  //                 return ListView.builder(
  //                   itemCount: aTour!.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) =>
  //                                     VacationDetails(tour: aTour[index])));
  //                       },
  //                       child: buildATour(aTour[index]),
  //                     );
  //                   },
  //                 );
  //               } else {
  //                 return const Center(child: CircularProgressIndicator());
  //               }
  //             },
  //           )),
  //     ),
  //   );
  // }

  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
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
          money: formattedPrice.format(int.parse('${tour.priceTour}')),
        ),
      );
}
