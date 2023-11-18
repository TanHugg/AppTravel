import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/pages/admin_page.dart';
import '../../model/aTour.dart';
import '../../model/tourDetails.dart';
import '../../values/custom_snackbar.dart';
import '../../values/custom_text.dart';

class AddTourDetail extends StatefulWidget {
  const AddTourDetail(
      {super.key,
      required this.nameTour,
      required this.startDay,
      required this.startMonth,
      required this.startYear,
      required this.typeTour});

  final String nameTour;
  final int startDay;
  final int startMonth;
  final int startYear;
  final String typeTour;

  @override
  State<AddTourDetail> createState() => _AddTourDetailState();
}

class _AddTourDetailState extends State<AddTourDetail> {
  Future<aTour?> readTour(String nameTour, int startDay, int startMonth,
      int startYear, String? typeTour) async {
    final docUser = FirebaseFirestore.instance
        .collection("Tour")
        .where('startDay', isEqualTo: startDay)
        .where('startMonth', isEqualTo: startMonth)
        .where('startYear', isEqualTo: startYear)
        .where('typeTour', isEqualTo: typeTour);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return aTour.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  Future createTourDetails(tourDetails tourDetail) async {
    final docTourDetail =
        FirebaseFirestore.instance.collection("TourDetails").doc();
    tourDetail.idTourDetails = docTourDetail.id;

    final json = tourDetail.toJson();
    await docTourDetail.set(json);
  }

  final descriptionController = TextEditingController();
  final hotelController = TextEditingController();
  final placeTourController = TextEditingController();
  final priceNormalTourController = TextEditingController();
  final priceSpecialTourController = TextEditingController();
  final numberDayTourController = TextEditingController();
  final timeStartTourController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    hotelController.dispose();
    placeTourController.dispose();
    priceNormalTourController.dispose();
    priceSpecialTourController.dispose();
    numberDayTourController.dispose();
    timeStartTourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder<aTour?>(
            future: readTour(widget.nameTour, widget.startDay,
                widget.startMonth, widget.startYear, widget.typeTour),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No data found.'));
              }
              final aTour = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 14, right: 20, top: 20, bottom: 20),
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
                          padding: EdgeInsets.only(top: 24, left: 20),
                          child: Text('Chi tiết Tour',
                              style: GoogleFonts.lato(
                                  fontSize: 45,
                                  decoration: TextDecoration.none,
                                  color: Colors.black87)),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 24, right: 20),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: "Mô tả",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: hotelController,
                              decoration: InputDecoration(
                                labelText: "Loại khách sạn",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: placeTourController,
                              decoration: InputDecoration(
                                labelText: "Địa chỉ Tour",
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: priceNormalTourController,
                              decoration: InputDecoration(
                                labelText: "Giá vé máy bay hạng Phổ Thông",
                              ),
                            ),
                            const SizedBox(height: 35),
                            TextFormField(
                              controller: priceSpecialTourController,
                              decoration: InputDecoration(
                                labelText: "Giá vé máy bay hạng Thương Gia",
                              ),
                            ),
                            const SizedBox(height: 35),
                            TextFormField(
                              controller: numberDayTourController,
                              decoration: InputDecoration(
                                labelText: "Số ngày đi",
                              ),
                            ),
                            const SizedBox(height: 35),
                            TextFormField(
                              controller: timeStartTourController,
                              decoration: InputDecoration(
                                labelText: "Thời gian khởi hành",
                              ),
                            ),

                            //Nút Edit Profile
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 35, left: 190), //Xem lại
                              child: SizedBox(
                                  width: 230,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        final tourDetail = tourDetails(
                                            idTour: aTour.idTour,
                                            placeTour: placeTourController.text,
                                            timeStart:
                                                timeStartTourController.text,
                                            startDay: aTour.startDay,
                                            startMonth: aTour.startMonth,
                                            startYear: aTour.startYear,
                                            imageTourDetails: '',
                                            description:
                                                descriptionController.text,
                                            dayEnd: int.tryParse(
                                                numberDayTourController.text),
                                            hotel: hotelController.text,
                                            priceFlightEconomy:
                                                priceNormalTourController.text,
                                            priceFlightBusiness:
                                                priceSpecialTourController
                                                    .text);
                                        createTourDetails(tourDetail);
                                        CustomSnackbar.show(
                                            context, "Cập nhật thành công");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminPage()));

                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffffd500),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      child: const CustomText(
                                          text: 'Cập nhật',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          height: 1.3))),
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

InputDecoration decoration(String labelText) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white70)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white70));
}
