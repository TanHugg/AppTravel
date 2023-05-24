import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aFlight.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/pages/bill_page.dart';
import 'package:travel_app/values/custom_text.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket(
      {Key? key,
      required this.nameTours,
      required this.addressCurrent,
      required this.tour})
      : super(key: key);

  final String nameTours;
  final String addressCurrent;
  final aTour tour;

  //Hàm đăng ký Flight từ dữ liệu lên Firebase
  void createFlight(String nameFlight, int priceFlight, idTour) {
    final flight = aFlight(
        nameFlight: nameFlight, priceFlight: priceFlight, idTour: idTour);

    Future createAFlight(aFlight flight) async {
      final docUser = FirebaseFirestore.instance.collection('Fly').doc();
      flight.idFlight = docUser.id;

      final json = flight.toJson();
      await docUser.set(json);
    }

    createAFlight(flight);
  }

  //Đổ dữ liệu vào Firebase collection Fly
  void createFlights() async {
    createFlight('Gatwick Airplanes', 1100, '');
    createFlight('Austrian Airplanes', 845, '');
  }

  //Đọc dữ liệu từ Database xuống khi đúng tên mà bạn truyền vô
  Future<aFlight?> readFlight(String nameFlight) async {
    final docUser = FirebaseFirestore.instance
        .collection("Fly")
        .where('nameFlight', isEqualTo: nameFlight);
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return aFlight.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //createFlights();
    return Container(
      color: Color(0xffe5e5e5),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              width: size.width,
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  color: Colors.pink,
                  image: DecorationImage(
                      image: AssetImage('assets/images/flyIntro.jpg'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 35,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30, top: 65),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(13),
                    backgroundColor: Colors.black38,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(height: 13),
          Text.rich(TextSpan(
              text: 'Book',
              style: GoogleFonts.neucha(
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: Colors.black,
                  decoration: TextDecoration.none),
              children: <TextSpan>[
                TextSpan(
                    text: ' Tickets',
                    style: GoogleFonts.neucha(
                        fontSize: 42,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        color: Colors.black,
                        decoration: TextDecoration.none))
              ])),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: readFlight('Austrian Airplanes'),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        final flight = snapShot.data;
                        flight!.idTour =
                            tour.idTour; //Flight lúc này đang đủ dữ liệu
                        return flight == null
                            ? Center(
                                child: Text('No Find Tour !'),
                              )
                            : bookTickets(
                                size,
                                nameTours,
                                () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BillPage(
                                                    flight: flight,
                                                    tour: tour,
                                                  ))),
                                      print(
                                          'Bạn đã nhấp vào Austrian Airplanes'),
                                    },
                                'plane_1',
                                '${flight.nameFlight}',
                                flight.priceFlight!);
                      } else if (snapShot.hasError) {
                        // Xử lý trường hợp lỗi
                        return Center(child: Text('Error: ${snapShot.error}'));
                      } else {
                        // Hiển thị widget loading khi đang tải dữ liệu
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                    future: readFlight('Gatwick Airplanes'),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        final flight = snapShot.data;
                        return flight == null
                            ? Center(
                                child: Text('No Find Flight !'),
                              )
                            : bookTickets(
                                size,
                                nameTours,
                                () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BillPage(
                                                    flight: flight,
                                                    tour: tour,
                                                  ))),
                                      print(
                                          'Bạn đã nhấp vào Gatwick Airplanes'),
                                    },
                                'plane_2',
                                '${flight.nameFlight}',
                                flight.priceFlight!);
                      } else if (snapShot.hasError) {
                        // Xử lý trường hợp lỗi
                        return Center(child: Text('Error: ${snapShot.error}'));
                      } else {
                        // Hiển thị widget loading khi đang tải dữ liệu
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget bookTickets(Size size, String nameTours, Function() onTap,
      String nameImages, String nameAirplane, int moneyAirplane) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: 265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xfff8f9fa),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                width: size.width,
                height: 80,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          children: <Widget>[
                            CustomText(
                                text: 'ORD',
                                color: Color(0xffff9f1c),
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                height: 1),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: FaIcon(FontAwesomeIcons.compactDisc,
                                  color: Color(0xffff9f1c), size: 13),
                            ),
                            Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text('------------',
                                      style: TextStyle(
                                          color: Color(0xffadb5bd),
                                          fontSize: 20,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w200)),
                                ),
                                Positioned(
                                  left: 60,
                                  top: 0,
                                  child: FaIcon(
                                    FontAwesomeIcons.plane,
                                    size: 24,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: FaIcon(
                                FontAwesomeIcons.compactDisc,
                                color: Color(0xff9d4edd),
                                size: 13,
                              ),
                            ),
                            Spacer(),
                            CustomText(
                                text: 'TIA',
                                color: Color(0xff9d4edd),
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                height: 1),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 84,
                              child: CustomText(
                                  text: '${addressCurrent}',
                                  color: Color(0xff6c757d),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  height: 1),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 52),
                              child: CustomText(
                                  text: '12h 10m',
                                  color: Color(0xff242423),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  height: 1),
                            ),
                            Spacer(),
                            CustomText(
                                text: nameTours,
                                color: Color(0xff6c757d),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                                height: 1),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 13),
              Container(
                width: size.width,
                height: 50,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CustomText(
                            text: '18:10',
                            color: Color(0xff242423),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                            height: 1),
                        Spacer(),
                        CustomText(
                            text: '14:20',
                            color: Color(0xff242423),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                            height: 1)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Row(
                        children: <Widget>[
                          CustomText(
                              text: 'August 23,2020',
                              color: Color(0xff6c757d),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              height: 1),
                          Spacer(),
                          CustomText(
                              text: 'August 23,2020',
                              color: Color(0xff6c757d),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              height: 1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomText(
                  text: '- - - - - - - - - - - - - - - - - - - - - - - ',
                  color: Color(0xffadb5bd),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  height: 0),
              Container(
                width: size.width,
                height: 70,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 47,
                      height: 47,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(
                              side:
                                  BorderSide(width: 2, color: Colors.white24))),
                      child: Image.asset(
                        'assets/images/plane/${nameImages}.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    CustomText(
                        text: nameAirplane,
                        color: Color(0xff6c757d),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        height: 1.5),
                    Spacer(),
                    CustomText(
                        text: '\$${moneyAirplane}',
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                        height: 1.5)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
