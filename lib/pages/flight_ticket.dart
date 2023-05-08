import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/pages/bill_page.dart';
import 'package:travel_app/values/custom_text.dart';

class FlightTicket extends StatelessWidget {
  const FlightTicket({Key? key, required this.nameTours}) : super(key: key);

  final String nameTours;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  bookTickets(
                      size,
                      nameTours,
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BillPage())),
                            print('Bạn đã nhấp vào Austrian Airplanes'),
                          },
                      'plane_1',
                      'Austrian Airplanes',
                      845),
                  SizedBox(height: 20),
                  bookTickets(
                      size,
                      nameTours,
                      () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BillPage())),
                            print('Bạn đã nhấp vào Gatwick Airplanes'),
                          },
                      'plane_2',
                      'Gatwick Airplanes',
                      1100),
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
                                  text: 'Chicago',
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
