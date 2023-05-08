import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/values/helpers.dart';
import 'package:travel_app/widget/HomePage/search_tours.dart';
import 'package:travel_app/widget/HomePage/type_tours.dart';

import '../values/custom_text.dart';
import '../widget/Details/vacation_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TypeTours typeTours = TypeTours(
    refreshLayout: () {},
  );

  void _refreshLayout() {
    //Hàm bắt buộc class này phải dc reBuild
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 67, right: 20),
        child: Column(
          children: <Widget>[
            Container(
              //Container layout avata and infor
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: ShapeDecoration(
                        shape: CircleBorder(
                            side: BorderSide(width: 2, color: Colors.white24))),
                    child: Image.asset(
                      'assets/images/avata.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Hi! Hưg',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff111111)),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.locationDot,
                                    size: 20, color: Color(0xff6c757d)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CustomText(
                                      text: 'Mỹ Tho',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      height: 0,
                                      color: Color(0xff6c757d)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        print('Bạn đã nhấp vào cái chuông');
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.bell,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            //Container Search
            SearchTours(),
            //3 block mountain, beach, city,
            TypeTours(refreshLayout: _refreshLayout),
            //Container Explorer
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 15, left: 7),
                child: CustomText(
                    text: 'Explorer',
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.7,
                    height: 0,
                    color: Colors.black)),
            SizedBox(height: 10),
            //Container Tours
            Container(
              child: (typeTours.checkTypeTours() == 1)
                  ? typeToursBeach()
                  : (typeTours.checkTypeTours() == 2)
                      ? typeToursMoutain()
                      : (typeTours.checkTypeTours() == 3)
                          ? typeToursCity()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    aTours("ChinaMountain", 160, 150, 110, 80,
                                        70, 30, "\$700", () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VacationDetails(
                                                      assetImage:
                                                          'assets/images/picture_tours/ChinaMounDetails.jpg',
                                                      nameTours: 'Taij Hang',
                                                      locationTours:
                                                          'North Prades, China',
                                                      moneyTours: '\$700',
                                                      details: textHelpers
                                                          .textDetailsChina
                                                          .toString(),
                                                    )));
                                        print(
                                            'Bạn đã bấm vô ảnh ChinaMountain');
                                      });
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: aTours("SanBeach", 160, 200, 160,
                                          70, 80, 30, "\$1600", () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VacationDetails(
                                                        assetImage:
                                                            'assets/images/picture_tours/SanBeachDetails.jpg',
                                                        nameTours: 'San Diego',
                                                        locationTours:
                                                            'Carlsbad, San Marcos.',
                                                        moneyTours: '\$1600',
                                                        details: textHelpers
                                                            .textDetailsSanDiego
                                                            .toString(),
                                                      )));
                                          print('Bạn đã bấm vô ảnh SanBeach');
                                        });
                                      }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: aTours("ParisCity", 160, 200, 160,
                                          80, 70, 30, "\$900", () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VacationDetails(
                                                        assetImage:
                                                            'assets/images/picture_tours/ParisDetails.jpg',
                                                        nameTours:
                                                            'Paris Capital',
                                                        locationTours:
                                                            'Île-de-France',
                                                        moneyTours: '\$900',
                                                        details: textHelpers
                                                            .textDetailsParis
                                                            .toString(),
                                                      )));
                                          print('Bạn đã bấm vô ảnh ParisCity');
                                        });
                                      }),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    aTours("Gerald", 160, 200, 160, 70, 80, 30,
                                        "\$1800", () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VacationDetails(
                                                      assetImage:
                                                          'assets/images/picture_tours/SwitzerlandDetails.jpg',
                                                      nameTours:
                                                          'Jungfrau Mountain',
                                                      locationTours:
                                                          'Bernese Oberland, Bern',
                                                      moneyTours: '\$1800',
                                                      details: textHelpers
                                                          .textDetailsJungfrau
                                                          .toString(),
                                                    )));
                                        print('Bạn đã bấm vô ảnh Gerald');
                                      });
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: aTours("MexicoCity", 160, 140, 100,
                                          80, 70, 30, "\$1000", () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VacationDetails(
                                                        assetImage:
                                                            'assets/images/picture_tours/MexicoDetails.jpg',
                                                        nameTours: 'Los Cabos',
                                                        locationTours:
                                                            'Plaza Mexico',
                                                        moneyTours: '\$1000',
                                                        details: textHelpers
                                                            .textDetailsMexico
                                                            .toString(),
                                                      )));
                                          print('Bạn đã bấm vô ảnh MexicoCity');
                                        });
                                      }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: aTours("Switzerland", 160, 200,
                                          160, 80, 70, 30, "\$1200", () {
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VacationDetails(
                                                        assetImage:
                                                            'assets/images/picture_tours/SeaBeachDetails.jpg',
                                                        nameTours: 'Santorini',
                                                        locationTours:
                                                            'Thiga Island, Aegea',
                                                        moneyTours: '\$1200',
                                                        details: textHelpers
                                                            .textDetailsSantorini
                                                            .toString(),
                                                      )));
                                          print(
                                              'Bạn đã bấm vô ảnh Switzerland');
                                        });
                                      }),
                                    )
                                  ],
                                ),
                              ],
                            ),
            )
          ],
        ),
      ),
    );
  }

  Widget aTours(
      String nameImage,
      double widSizeBox,
      double heiSizeBox,
      double topPos,
      double leftPos,
      double widContain,
      double heiContain,
      String money,
      Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: widSizeBox,
              height: heiSizeBox,
              child: Image.asset(
                "assets/images/picture_tours/${nameImage}.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: topPos,
              left: leftPos,
              child: Container(
                width: widContain,
                height: heiContain,
                decoration: BoxDecoration(
                    color: Color(0xfff1faee),
                    borderRadius: BorderRadius.circular(21)),
                child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      money.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    )),
              ))
        ],
      ),
    );
  }

  Widget typeToursBeach() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            aTours("CotaRicaBeach", 160, 150, 110, 80, 70, 30, "\$800", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/CotaRicaDetails.jpg', //Sữa
                              nameTours: 'Cota Rica',
                              locationTours: 'North Brazil',
                              moneyTours: '\$800',
                              details: textHelpers.textDetailsCotaRica
                                  .toString(), //Sữa
                            )));
                print('Bạn đã bấm vô ảnh Cota Rica');
              });
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child:
                  aTours("SanBeach", 160, 200, 160, 70, 80, 30, "\$1600", () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VacationDetails(
                                assetImage:
                                    'assets/images/picture_tours/SanBeachDetails.jpg',
                                nameTours: 'San Diego',
                                locationTours: 'Carlsbad, San Marcos.',
                                moneyTours: '\$1600',
                                details:
                                    textHelpers.textDetailsSanDiego.toString(),
                              )));
                  print('Bạn đã bấm vô ảnh SanBeach');
                });
              }),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            aTours("NavagioBeach", 160, 200, 160, 70, 80, 30, "\$1800", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/NavagioDetails.jpg', //Sữa
                              nameTours: 'Navagio',
                              locationTours: 'NavagioBeach, Rome',
                              moneyTours: '\$1800',
                              details: textHelpers.textDetailsNavagio
                                  .toString(), //Sữa
                            )));
                print('Bạn đã bấm vô ảnh NavagioBeach');
              });
            }),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: aTours(
                    "Switzerland", 160, 200, 160, 80, 70, 30, "\$1200", () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VacationDetails(
                                  assetImage:
                                      'assets/images/picture_tours/SeaBeachDetails.jpg',
                                  nameTours: 'Santorini',
                                  locationTours: 'Thiga Island, Aegea',
                                  moneyTours: '\$1200',
                                  details: textHelpers.textDetailsSantorini
                                      .toString(),
                                )));
                    print('Bạn đã bấm vô ảnh Switzerland');
                  });
                }))
          ],
        ),
      ],
    );
  }

  Widget typeToursMoutain() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            aTours("Gerald", 160, 200, 160, 70, 80, 30, "\$1800", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/SwitzerlandDetails.jpg',
                              nameTours: 'Jungfrau Mountain',
                              locationTours: 'Bernese Oberland, Bern',
                              moneyTours: '\$1800',
                              details:
                                  textHelpers.textDetailsJungfrau.toString(),
                            )));
                print('Bạn đã bấm vô ảnh Gerald');
              });
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: aTours("ChinaMountain", 160, 150, 110, 80, 70, 30, "\$700",
                  () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VacationDetails(
                                assetImage:
                                    'assets/images/picture_tours/ChinaMounDetails.jpg',
                                nameTours: 'Taij Hang',
                                locationTours: 'North Prades, China',
                                moneyTours: '\$700',
                                details:
                                    textHelpers.textDetailsChina.toString(),
                              )));
                  print('Bạn đã bấm vô ảnh ChinaMountain');
                });
              }),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            aTours("FujiSijuMountain", 160, 200, 160, 70, 80, 30, "\$600", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/FujiSijuDetails.jpg', //Sữa
                              nameTours: 'Fuji Siju',
                              locationTours: 'Kito, Japan',
                              moneyTours: '\$600',
                              details: textHelpers.textDetailsFujiSiju
                                  .toString(), //Sữa
                            )));
                print('Bạn đã bấm vô ảnh FujiSijuMountain');
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget typeToursCity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            aTours("ParisCity", 160, 200, 160, 80, 70, 30, "\$900", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/ParisDetails.jpg',
                              nameTours: 'Paris Capital',
                              locationTours: 'Île-de-France',
                              moneyTours: '\$900',
                              details: textHelpers.textDetailsParis.toString(),
                            )));
                print('Bạn đã bấm vô ảnh ParisCity');
              });
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child:
                  aTours("MexicoCity", 160, 140, 100, 80, 70, 30, "\$1000", () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VacationDetails(
                                assetImage:
                                    'assets/images/picture_tours/MexicoDetails.jpg',
                                nameTours: 'Los Cabos',
                                locationTours: 'Plaza Mexico',
                                moneyTours: '\$1000',
                                details:
                                    textHelpers.textDetailsMexico.toString(),
                              )));
                  print('Bạn đã bấm vô ảnh MexicoCity');
                });
              }),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            aTours("Rome", 160, 200, 160, 70, 80, 30, "\$2800", () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VacationDetails(
                              assetImage:
                                  'assets/images/picture_tours/Rome.jpg', //Sữa
                              nameTours: 'Colosseum',
                              locationTours: 'Rome, Italia',
                              moneyTours: '\$2800',
                              details: textHelpers.textDetailsColoseeum
                                  .toString(), //Sữa
                            )));
                print('Bạn đã bấm vô ảnh FujiSijuMountain');
              });
            }),
          ],
        ),
      ],
    );
  }
}
