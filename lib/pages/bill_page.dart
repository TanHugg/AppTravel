import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aFlight.dart';
import 'package:travel_app/model/billTotal.dart';
import 'package:travel_app/pages/main_page.dart';
import 'package:travel_app/values/custom_snackbar.dart';
import 'package:travel_app/values/custom_text.dart';

import '../model/aTour.dart';
import '../model/users.dart';

import 'package:intl/intl.dart';

class BillPage extends StatelessWidget {
  const BillPage({Key? key, required this.flight, required this.tour})
      : super(key: key);

  final aFlight flight;
  final aTour tour;

  static final formattedPrice =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('id', isEqualTo: tour.idUser);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  Future createBill(billTotal bill) async {
    final docUser = FirebaseFirestore.instance.collection("Bill").doc();
    bill.idBill = docUser.id;

    final json = bill.toJson();
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late Users usersCurrent;
    DateTime dateTimeNow = DateTime.now();
    return Container(
      color: Color(0xffe5e5e5),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 120, right: 20),
            child: Container(
              width: size.width,
              height: size.height * 3 / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xffffffff)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: FutureBuilder(
                    future: readUsers(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        final users = snapShot.data;
                        usersCurrent = users!; //Đã lấy đủ dữ liệu bỏ vào users
                        return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                      text: 'Tên: ${users.nameUser}',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text: 'Số điện thoại: 0${users.numberPhone}',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text: 'Email: ${users.email}',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 20),
                                  CustomText(
                                      text: '1. Tên Tour: ${tour.nameTour}',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text:
                                          '2. Hãng máy bay: ${flight.nameFlight}',
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 5),
                                  CustomText(
                                      text:
                                      '3. Hạng: ${flight.rank}',
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 25),
                                  CustomText(
                                      text: 'Money ',
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 25),
                                  CustomText(
                                      text:
                                          'Giá Tour:  ${formattedPrice.format(int.parse('${tour.priceTour}'))} ',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.2,
                                      height: 1),
                                  SizedBox(height: 15),
                                  CustomText(
                                      text:
                                          'Giá vé Máy Bay:  ${formattedPrice.format(int.parse('${flight.priceFlight}'))}',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.2,
                                      height: 1),
                                ],
                              );
                      } else if (snapShot.hasError) {
                        // Xử lý trường hợp lỗi
                        return Center(child: Text('Error: ${snapShot.error}'));
                      } else {
                        // Hiển thị widget loading khi đang tải dữ liệu
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 50,
            child: Text(
              'Hóa Đơn',
              style: GoogleFonts.pacifico(
                  fontSize: 65,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            top: 625,
            left: 12,
            child: Container(
              width: 370,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 15),
                    child: CustomText(
                        text:
                            'Tổng:  ${formattedPrice.format(int.parse('${int.parse(tour.priceTour!) + int.parse(flight.priceFlight!)}'))}',
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        height: 1),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: SizedBox(
                          width: 140,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              final bill = billTotal(
                                  idTour: tour.idTour,
                                  idFlight: flight.idFlight,
                                  priceBill: int.parse(
                                      tour.priceTour! + flight.priceFlight!),
                                  idUser: tour.idUser,
                                  dateTime: dateTimeNow.toString(),
                                  checkBought: false);
                              createBill(bill);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                              CustomSnackbar.show(context, 'Thanh toán thành công!');
                            },
                            child: Text(
                              'Pay',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: SizedBox(
                          width: 140,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.white,
                                side: BorderSide(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
