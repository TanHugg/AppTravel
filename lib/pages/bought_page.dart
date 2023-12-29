import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/BoughtTour/custom_bought_tour.dart';
import 'package:travel_app/widget/BoughtTour/show_bought_tour.dart';
import '../model/aTour.dart';
import '../model/billTotal.dart';
import '../model/users.dart';
import '../values/custom_snackbar.dart';

class BoughtPage extends StatefulWidget {
  const BoughtPage({Key? key, required this.users}) : super(key: key);

  final Users users;
  @override
  State<BoughtPage> createState() => _BoughtPageState();
}

class _BoughtPageState extends State<BoughtPage> {
  List<aTour> _favoriteTours = [];

 //User hiện tại
  Stream<List<billTotal>> readBill() => FirebaseFirestore.instance
      .collection('Bill')
      .where('idUser', isEqualTo: widget.users.idUser.toString())
      .where('checkBought',isEqualTo: false)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => billTotal.fromJson(doc.data())).toList());

  // Future deleteFavoriteDetails(String idUser, String idTour) async {
  //   final docFavoriteDetails = FirebaseFirestore.instance
  //       .collection("FavoriteDetails")
  //       .where('idUser', isEqualTo: idUser)
  //       .where('idTour', isEqualTo: idTour);
  //   final snapshot = await docFavoriteDetails.get();
  //   for (final doc in snapshot.docs) {
  //     await doc.reference.delete();
  //   }
  //   // Xóa aTour khỏi danh sách trong State object và rebuild widget tree
  //   setState(() {
  //     _favoriteTours.removeWhere((tour) => tour.idTour == idTour);
  //   });
  //   CustomSnackbar.show(context, 'Xóa thành công');
  // }

  Future updateBillDetails(String idBill) async {
    final cdoBillDetails = FirebaseFirestore.instance
        .collection("Bill")
        .where('idBill', isEqualTo: idBill);
    final snapshot = await cdoBillDetails.get();
    for (final doc in snapshot.docs) {
      await doc.reference.update({'checkBought': true});
    }
    // Xóa aTour khỏi danh sách trong State object và rebuild widget tree
    setState(() {

    });
    CustomSnackbar.show(context, 'Xóa thành công');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Thông số size của điện thoại
    return Scaffold(
      body: Padding(
        // padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 15),
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        child: SizedBox(
                          width: 350,
                          height: 270,
                          child: Image.asset(
                            "assets/images/nobackground/CoconutTree.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        child: Text.rich(
                          TextSpan(
                            text: 'Tour',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' đã mua',
                                style: GoogleFonts.poppins(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: 450,
                    width: size.width,
                    child: StreamBuilder<List<billTotal>>(
                      stream: readBill(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<billTotal>> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            'Something went wrong! ${snapshot.error}',
                          );
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
                                          bill: billTotal[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: buildTour(billTotal[index], index, context),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildTour(billTotal bill) => Padding(
  //       padding: EdgeInsets.only(bottom: 20),
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: Color(0xffedede9),
  //             borderRadius: BorderRadius.circular(20)),
  //         child: CustomBoughtTour(bill: bill),
  //       ),
  //     );

  Widget buildTour(billTotal bill, int index, BuildContext context) => Dismissible(
    key: UniqueKey(),
    background: Container(
      decoration: BoxDecoration(
          color: Color(0xffd81159),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
          padding: EdgeInsets.only(left: 25, top: 70),
          child: FaIcon(
            FontAwesomeIcons.trashCan,
            size: 55,
            color: Colors.white,
          )),
    ),
    secondaryBackground: Container(color: Colors.red),
    direction: DismissDirection.startToEnd,
    confirmDismiss: (direction) async {
      if (direction == DismissDirection.startToEnd) {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cảnh báo'),
            content: Text('Bạn có chắc muốn hủy Tour này không?'),
            actions: <Widget>[
              TextButton(
                child: Text('Hủy'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Xóa'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
      }
      return Future.value(false); // Không cần xác nhận khi vuốt theo hướng khác
    },
    onDismissed: (direction) {
      if (direction == DismissDirection.startToEnd) {
        updateBillDetails(
            bill.idBill.toString());
        // bill.checkBought = true;
        // Xóa tour
        print('Đã xoáaaaaaaaa !!');
        setState(() {
          // _favoriteTours.removeAt(index);
        });
      }
    },
    child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          width: 360,
          decoration: BoxDecoration(
              color: Color(0xffedede9),
              borderRadius: BorderRadius.circular(20)),
          child: CustomBoughtTour(bill: bill),
        ),
      ),
  );
}
