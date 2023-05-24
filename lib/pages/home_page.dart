import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/model/users.dart';
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
  //Lấy UserAuthen hiện tại
  final user_auth = FirebaseAuth.instance.currentUser!;

  //Lấy thuộc tính Email trong FirebaseStore collection Users
  Future<Users?> readUsers() async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .where('email', isEqualTo: user_auth.email.toString());
    final snapshot = await docUser.get();

    if (snapshot.docs.isNotEmpty) {
      return Users.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  //Lấy thuộc tính nameTour trong FirebaseStore collection Tour
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

  //Hàm đăng ký Tour từ dữ liệu lên Firebase
  void createATour(String nameTour, int priceTour, bool isFavorite, idUser) {
    final tour = aTour(
        nameTour: nameTour,
        priceTour: priceTour,
        isFavorite: isFavorite,
        idUser: idUser);

    Future createTour(aTour tour) async {
      final docUser = FirebaseFirestore.instance.collection('Tour').doc();
      tour.idTour = docUser.id;

      final json = tour.toJson();
      await docUser.set(json);
    }

    createTour(tour);
  }

  //Hàm đưa dữ liệu lên Firebase
  void createTours() async {
    createATour('Cota Rica', 800, false, '');
    createATour('San Diego', 1600, false, '');
    createATour('Navagio', 1800, false, '');
    createATour('Jungfrau Mountain', 1800, false, '');
    createATour('Fuji Siju', 600, false, '');
    createATour('Taij Hang', 700, false, '');
    createATour('Paris Capital', 900, false, '');
    createATour('Colosseum', 2800, false, '');
    createATour('Los Cabos', 1000, false, '');
    createATour('Santorini', 1200, false, '');
  }

  //Gọi hàm này để load lại Layout
  TypeTours typeTours = TypeTours(
    refreshLayout: () {},
  );

  //Hàm bắt buộc class này phải dc reBuild
  void _refreshLayout() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //createTours(); Khi nào cần ghi dữ liệu Tour lên Database thì mở cái này lên
  }

  String addressCurrent = '';
  String idUserCurrent = '';

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
                  FutureBuilder(
                    future: readUsers(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        final users =
                            snapShot.data; //Đã lấy đủ dữ liệu bỏ vào users
                        addressCurrent = users!.address;
                        idUserCurrent = users.idUser;
                        return users == null
                            ? Center(child: Text('No Find User !'))
                            : Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Hi! ${users.nameUser}',
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff111111)),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            FaIcon(FontAwesomeIcons.locationDot,
                                                size: 20,
                                                color: Color(0xff6c757d)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CustomText(
                                                  text: users.address,
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
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
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
                                                    FutureBuilder(
                                                      future:
                                                          readTour('Taij Hang'),
                                                      builder:
                                                          (context, snapShot) {
                                                        if (snapShot.hasData) {
                                                          //Hình như cái tour này nó biến mất
                                                          final tour = snapShot
                                                              .data; //Khúc này là thằng tour nó đã có dữ liệu
                                                          tour!.idUser =
                                                              idUserCurrent; //Gán thêm idUser nữa là đủ
                                                          return tour == null
                                                              ? Center(
                                                                  child: Text(
                                                                      'No Find Tour !'),
                                                                )
                                                              : VacationDetails(
                                                                  assetImage:
                                                                      'assets/images/picture_tours/ChinaMounDetails.jpg',
                                                                  // nameTours:
                                                                  //     '${tour.nameTour}',
                                                                  locationTours:
                                                                      'North Prades, China',
                                                                  // moneyTours:
                                                                  //     '${tour.priceTour}',
                                                                  details: textHelpers
                                                                      .textDetailsChina
                                                                      .toString(),

                                                                  //Gửi address và id của User qua layout tiếp theo
                                                                  addressCurrent:
                                                                      addressCurrent,
                                                                  idUserCurrent:
                                                                      idUserCurrent,
                                                                  tour: tour,
                                                                );
                                                        } else if (snapShot
                                                            .hasError) {
                                                          // Xử lý trường hợp lỗi
                                                          return Center(
                                                              child: Text(
                                                                  'Error: ${snapShot.error}'));
                                                        } else {
                                                          // Hiển thị widget loading khi đang tải dữ liệu
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                      },
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
                                                      FutureBuilder(
                                                        future: readTour(
                                                            'San Diego'),
                                                        builder: (context,
                                                            snapShot) {
                                                          if (snapShot
                                                              .hasData) {
                                                            final tour =
                                                                snapShot.data;
                                                            tour!.idUser =
                                                                idUserCurrent;
                                                            return tour == null
                                                                ? Center(
                                                                    child: Text(
                                                                        'No Find Tour !'),
                                                                  )
                                                                : VacationDetails(
                                                                    assetImage:
                                                                        'assets/images/picture_tours/SanBeachDetails.jpg',
                                                                    // nameTours:
                                                                    //     '${tour.nameTour}',
                                                                    locationTours:
                                                                        'Carlsbad, San Marcos.',
                                                                    // moneyTours:
                                                                    //     '${tour.priceTour}',
                                                                    details: textHelpers
                                                                        .textDetailsSanDiego
                                                                        .toString(),
                                                                    addressCurrent:
                                                                        addressCurrent,
                                                                    idUserCurrent:
                                                                        idUserCurrent,
                                                                    tour: tour,
                                                                  );
                                                          } else if (snapShot
                                                              .hasError) {
                                                            // Xử lý trường hợp lỗi
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapShot.error}'));
                                                          } else {
                                                            // Hiển thị widget loading khi đang tải dữ liệu
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                        },
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
                                                      FutureBuilder(
                                                        future: readTour(
                                                            'Paris Capital'),
                                                        builder: (context,
                                                            snapShot) {
                                                          if (snapShot
                                                              .hasData) {
                                                            final tour =
                                                                snapShot.data;
                                                            tour!.idUser =
                                                                idUserCurrent;
                                                            return tour == null
                                                                ? Center(
                                                                    child: Text(
                                                                        'No Find Tour !'),
                                                                  )
                                                                : VacationDetails(
                                                                    assetImage:
                                                                        'assets/images/picture_tours/ParisDetails.jpg',
                                                                    // nameTours:
                                                                    //     '${tour.nameTour}',
                                                                    locationTours:
                                                                        'Île-de-France',
                                                                    // moneyTours:
                                                                    //     '${tour.priceTour}',
                                                                    details: textHelpers
                                                                        .textDetailsParis
                                                                        .toString(),
                                                                    addressCurrent:
                                                                        addressCurrent,
                                                                    idUserCurrent:
                                                                        idUserCurrent,
                                                                    tour: tour,
                                                                  );
                                                          } else if (snapShot
                                                              .hasError) {
                                                            // Xử lý trường hợp lỗi
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapShot.error}'));
                                                          } else {
                                                            // Hiển thị widget loading khi đang tải dữ liệu
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                        },
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
                                                    FutureBuilder(
                                                      future: readTour(
                                                          'Jungfrau Mountain'),
                                                      builder:
                                                          (context, snapShot) {
                                                        if (snapShot.hasData) {
                                                          final tour =
                                                              snapShot.data;
                                                          tour!.idUser =
                                                              idUserCurrent;
                                                          return tour == null
                                                              ? Center(
                                                                  child: Text(
                                                                      'No Find Tour !'),
                                                                )
                                                              : VacationDetails(
                                                                  assetImage:
                                                                      'assets/images/picture_tours/SwitzerlandDetails.jpg',
                                                                  // nameTours:
                                                                  //     '${tour.nameTour}',
                                                                  locationTours:
                                                                      'Bernese Oberland, Bern',
                                                                  // moneyTours:
                                                                  //     '${tour.priceTour}',
                                                                  details: textHelpers
                                                                      .textDetailsJungfrau
                                                                      .toString(),
                                                                  addressCurrent:
                                                                      addressCurrent,
                                                                  idUserCurrent:
                                                                      idUserCurrent,
                                                                  tour: tour,
                                                                );
                                                        } else if (snapShot
                                                            .hasError) {
                                                          // Xử lý trường hợp lỗi
                                                          return Center(
                                                              child: Text(
                                                                  'Error: ${snapShot.error}'));
                                                        } else {
                                                          // Hiển thị widget loading khi đang tải dữ liệu
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                      },
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
                                                      FutureBuilder(
                                                        future: readTour(
                                                            'San Diego'),
                                                        builder: (context,
                                                            snapShot) {
                                                          if (snapShot
                                                              .hasData) {
                                                            final tour =
                                                                snapShot.data;
                                                            tour!.idUser =
                                                                idUserCurrent;
                                                            return tour == null
                                                                ? Center(
                                                                    child: Text(
                                                                        'No Find Tour !'),
                                                                  )
                                                                : VacationDetails(
                                                                    assetImage:
                                                                        'assets/images/picture_tours/MexicoDetails.jpg',
                                                                    // nameTours:
                                                                    //     '${tour.nameTour}',
                                                                    locationTours:
                                                                        'Plaza Mexico',
                                                                    // moneyTours:
                                                                    //     '${tour.priceTour}',
                                                                    details: textHelpers
                                                                        .textDetailsMexico
                                                                        .toString(),
                                                                    addressCurrent:
                                                                        addressCurrent,
                                                                    idUserCurrent:
                                                                        idUserCurrent,
                                                                    tour: tour,
                                                                  );
                                                          } else if (snapShot
                                                              .hasError) {
                                                            // Xử lý trường hợp lỗi
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapShot.error}'));
                                                          } else {
                                                            // Hiển thị widget loading khi đang tải dữ liệu
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                        },
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
                                                      FutureBuilder(
                                                        future: readTour(
                                                            'San Diego'),
                                                        builder: (context,
                                                            snapShot) {
                                                          if (snapShot
                                                              .hasData) {
                                                            final tour =
                                                                snapShot.data;
                                                            tour!.idUser =
                                                                idUserCurrent;
                                                            return tour == null
                                                                ? Center(
                                                                    child: Text(
                                                                        'No Find Tour !'),
                                                                  )
                                                                : VacationDetails(
                                                                    assetImage:
                                                                        'assets/images/picture_tours/SeaBeachDetails.jpg',
                                                                    // nameTours:
                                                                    //     '${tour.nameTour}',
                                                                    locationTours:
                                                                        'Thiga Island, Aegea',
                                                                    // moneyTours:
                                                                    //     '${tour.priceTour}',
                                                                    details: textHelpers
                                                                        .textDetailsSantorini
                                                                        .toString(),
                                                                    addressCurrent:
                                                                        addressCurrent,
                                                                    idUserCurrent:
                                                                        idUserCurrent,
                                                                    tour: tour,
                                                                  );
                                                          } else if (snapShot
                                                              .hasError) {
                                                            // Xử lý trường hợp lỗi
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapShot.error}'));
                                                          } else {
                                                            // Hiển thị widget loading khi đang tải dữ liệu
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                        },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Cota Rica'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/CotaRicaDetails.jpg', //Sữa
                                          // nameTours: '${tour.nameTour}',
                                          locationTours: 'North Brazil',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers
                                              .textDetailsCotaRica
                                              .toString() //Sữa
                                          ,
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                          builder: (context) => FutureBuilder(
                                future: readTour('San Diego'),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    final tour = snapShot.data;
                                    tour!.idUser = idUserCurrent;
                                    return tour == null
                                        ? Center(
                                            child: Text('No Find Tour !'),
                                          )
                                        : VacationDetails(
                                            assetImage:
                                                'assets/images/picture_tours/SanBeachDetails.jpg',
                                            // nameTours: '${tour.nameTour}',
                                            locationTours:
                                                'Carlsbad, San Marcos.',
                                            // moneyTours: '${tour.priceTour}',
                                            details: textHelpers
                                                .textDetailsSanDiego
                                                .toString(),
                                            addressCurrent: addressCurrent,
                                            idUserCurrent: idUserCurrent,
                                            tour: tour,
                                          );
                                  } else if (snapShot.hasError) {
                                    // Xử lý trường hợp lỗi
                                    return Center(
                                        child:
                                            Text('Error: ${snapShot.error}'));
                                  } else {
                                    // Hiển thị widget loading khi đang tải dữ liệu
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Navagio'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/NavagioDetails.jpg', //Sữa
                                          // nameTours: '${tour.nameTour}',
                                          locationTours: 'NavagioBeach, Rome',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers
                                              .textDetailsNavagio
                                              .toString() //Sữa
                                          ,
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                            builder: (context) => FutureBuilder(
                                  future: readTour('Santorini'),
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      final tour = snapShot.data;
                                      tour!.idUser = idUserCurrent;
                                      return tour == null
                                          ? Center(
                                              child: Text('No Find Tour !'),
                                            )
                                          : VacationDetails(
                                              assetImage:
                                                  'assets/images/picture_tours/SeaBeachDetails.jpg',
                                              // nameTours: '${tour.nameTour}',
                                              locationTours:
                                                  'Thiga Island, Aegea',
                                              // moneyTours: '${tour.priceTour}',
                                              details: textHelpers
                                                  .textDetailsSantorini
                                                  .toString(),
                                              addressCurrent: addressCurrent,
                                              idUserCurrent: idUserCurrent,
                                              tour: tour,
                                            );
                                    } else if (snapShot.hasError) {
                                      // Xử lý trường hợp lỗi
                                      return Center(
                                          child:
                                              Text('Error: ${snapShot.error}'));
                                    } else {
                                      // Hiển thị widget loading khi đang tải dữ liệu
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Jungfrau Mountain'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/SwitzerlandDetails.jpg',
                                          // nameTours: '${tour.nameTour}',
                                          locationTours:
                                              'Bernese Oberland, Bern',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers
                                              .textDetailsJungfrau
                                              .toString(),
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                          builder: (context) => FutureBuilder(
                                future: readTour('Taij Hang'),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    final tour = snapShot.data;
                                    tour!.idUser = idUserCurrent;
                                    return tour == null
                                        ? Center(
                                            child: Text('No Find Tour !'),
                                          )
                                        : VacationDetails(
                                            assetImage:
                                                'assets/images/picture_tours/ChinaMounDetails.jpg',
                                            // nameTours: '${tour.nameTour}',
                                            locationTours:
                                                'North Prades, China',
                                            // moneyTours: '${tour.priceTour}',
                                            details: textHelpers
                                                .textDetailsChina
                                                .toString(),
                                            addressCurrent: addressCurrent,
                                            idUserCurrent: idUserCurrent,
                                            tour: tour,
                                          );
                                  } else if (snapShot.hasError) {
                                    // Xử lý trường hợp lỗi
                                    return Center(
                                        child:
                                            Text('Error: ${snapShot.error}'));
                                  } else {
                                    // Hiển thị widget loading khi đang tải dữ liệu
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Fuji Siju'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/FujiSijuDetails.jpg', //Sữa
                                          // nameTours: '${tour.nameTour}',
                                          locationTours: 'Kito, Japan',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers
                                              .textDetailsFujiSiju
                                              .toString() //Sữa
                                          ,
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Paris Capital'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/ParisDetails.jpg',
                                          // nameTours: '${tour.nameTour}',
                                          locationTours: 'Île-de-France',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers.textDetailsParis
                                              .toString(),
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
                          builder: (context) => FutureBuilder(
                                future: readTour('Los Cabos'),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    final tour = snapShot.data;
                                    tour!.idUser = idUserCurrent;
                                    return tour == null
                                        ? Center(
                                            child: Text('No Find Tour !'),
                                          )
                                        : VacationDetails(
                                            assetImage:
                                                'assets/images/picture_tours/MexicoDetails.jpg',
                                            // nameTours: '${tour.nameTour}',
                                            locationTours: 'Plaza Mexico',
                                            // moneyTours: '${tour.priceTour}',
                                            details: textHelpers
                                                .textDetailsMexico
                                                .toString(),
                                            addressCurrent: addressCurrent,
                                            idUserCurrent: idUserCurrent,
                                            tour: tour,
                                          );
                                  } else if (snapShot.hasError) {
                                    // Xử lý trường hợp lỗi
                                    return Center(
                                        child:
                                            Text('Error: ${snapShot.error}'));
                                  } else {
                                    // Hiển thị widget loading khi đang tải dữ liệu
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
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
                        builder: (context) => FutureBuilder(
                              future: readTour('Colosseum'),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  final tour = snapShot.data;
                                  tour!.idUser = idUserCurrent;
                                  return tour == null
                                      ? Center(
                                          child: Text('No Find Tour !'),
                                        )
                                      : VacationDetails(
                                          assetImage:
                                              'assets/images/picture_tours/Rome.jpg', //Sữa
                                          // nameTours: '${tour.nameTour}',
                                          locationTours: 'Rome, Italia',
                                          // moneyTours: '${tour.priceTour}',
                                          details: textHelpers
                                              .textDetailsColoseeum
                                              .toString() //Sữa
                                          ,
                                          addressCurrent: addressCurrent,
                                          idUserCurrent: idUserCurrent,
                                          tour: tour,
                                        );
                                } else if (snapShot.hasError) {
                                  // Xử lý trường hợp lỗi
                                  return Center(
                                      child: Text('Error: ${snapShot.error}'));
                                } else {
                                  // Hiển thị widget loading khi đang tải dữ liệu
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
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
