import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/widget/Admin/add_details_tour.dart';

import '../../model/aTour.dart';
import '../../values/custom_text.dart';

class AddTour extends StatefulWidget {
  const AddTour({super.key});

  @override
  State<AddTour> createState() => _AddTourState();
}

class _AddTourState extends State<AddTour> {
  Future createATour(aTour tour) async {
    final docTour = FirebaseFirestore.instance.collection("Tour").doc();
    tour.idTour = docTour.id;

    final json = tour.toJson();
    await docTour.set(json);
  }

  final nameTourController = TextEditingController();
  final priceController = TextEditingController();
  final dayStartTourController = TextEditingController();
  final monthStartTourController = TextEditingController();
  final yearStartTourController = TextEditingController();
  final typeStartTourController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameTourController.dispose();
    priceController.dispose();
    dayStartTourController.dispose();
    monthStartTourController.dispose();
    yearStartTourController.dispose();
    typeStartTourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        padding: EdgeInsets.only(left: 14, right: 20, top: 30, bottom: 20),
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
                child: Text('Thêm Tour',
                    style: GoogleFonts.lato(
                        fontSize: 50,
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
                    controller: nameTourController,
                    decoration: InputDecoration(
                      labelText: "Tên Tour",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: "Giá",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: dayStartTourController,
                    decoration: InputDecoration(
                      labelText: "Ngày đi",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: monthStartTourController,
                    decoration: InputDecoration(
                      labelText: "Tháng đi",
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: yearStartTourController,
                    decoration: InputDecoration(
                      labelText: "Năm đi",
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: typeStartTourController,
                    decoration: InputDecoration(
                      labelText: "Loại Tour",
                    ),
                  ),

                  //Nút Edit Profile
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 190), //Xem lại
                    child: SizedBox(
                        width: 230,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              final tour = aTour(
                                  nameTour: nameTourController.text,
                                  priceTour: priceController.text,
                                  typeTour: typeStartTourController.text,
                                  idUser: '',
                                  startDay: int.parse(dayStartTourController.text),
                                  startMonth: int.parse(monthStartTourController.text),
                                  startYear: int.parse(yearStartTourController.text)
                              );
                              createATour(tour);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTourDetail(
                                          nameTour: nameTourController.text,
                                          startDay: int.parse(
                                              dayStartTourController.text),
                                          startMonth: int.parse(
                                              monthStartTourController.text),
                                          startYear: int.parse(
                                              yearStartTourController.text),
                                          typeTour:
                                              typeStartTourController.text)));
                              // print(nameTourController.text);
                              // print(priceController.text);
                              // print(typeStartTourController.text);
                              // print(int.tryParse(dayStartTourController.text));
                              // print(int.tryParse(monthStartTourController.text));
                              // print(int.tryParse(yearStartTourController.text));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffffd500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const CustomText(
                                text: 'Tiếp theo',
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
    ));
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
