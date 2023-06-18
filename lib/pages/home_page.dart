import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/model/tourDetails.dart';
import 'package:travel_app/model/users.dart';
import 'package:travel_app/widget/HomePage/bell_notification.dart';
import 'package:travel_app/widget/HomePage/search_tours.dart';
import 'package:travel_app/widget/HomePage/type_tours.dart';
import '../values/custom_text.dart';
import '../widget/Details/vacation_details.dart';
import '../widget/HomePage/custom_tours.dart';
import 'package:intl/intl.dart';

import '../widget/ProfilePage/Custom_Information/MyClipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.users}) : super(key: key);

  final Users users;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user_auth = FirebaseAuth.instance.currentUser!;

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

  //Lấy ra tất cả tour có trong Firebase thông qua typeTour truyền vô
  Stream<List<aTour>> readListTour(String typeTour, String searchTour) =>
      (typeTour == '')
          ? FirebaseFirestore.instance
              .collection('Tour')
              .where('nameTour', isGreaterThanOrEqualTo: searchTour)
              .snapshots()
              .map((snapshot) => snapshot.docs
                  .map((doc) => aTour.fromJson(doc.data()))
                  .toList())
          : FirebaseFirestore.instance
              .collection('Tour')
              .where('typeTour', isEqualTo: typeTour)
              .snapshots()
              .map((snapshot) => snapshot.docs
                  .map((doc) => aTour.fromJson(doc.data()))
                  .toList());

  //Hàm đăng ký Tour từ dữ liệu lên Firebase
  void createATour(String nameTour, String priceTour, String typeTour,
      bool isFavorite, idUser, int startDay, int startMonth, int startYear) {
    final tour = aTour(
      nameTour: nameTour,
      priceTour: priceTour,
      typeTour: typeTour,
      isFavorite: isFavorite,
      idUser: idUser,
      startDay: startDay,
      startMonth: startMonth,
      startYear: startYear,
    );

    Future createTour(aTour tour) async {
      final docUser = FirebaseFirestore.instance.collection('Tour').doc();
      tour.idTour = docUser.id;

      final json = tour.toJson();
      await docUser.set(json);
    }

    createTour(tour);
  }

  //Hàm đưa dữ liệu lên Firebase
  /*void createTours() async {
    createATour('Cota Rica', '8000000', 'beach', false, '', 14, 6, 2023);
    createATour('San Diego', '16000000', 'beach', false, '', 15, 6, 2023);
    createATour('Navagio', '18000000', 'beach', false, '', 15, 6, 2023);
    createATour('Jungfrau', '18000000', 'mountain', false, '', 16, 6, 2023);
    createATour('Fuji Siju', '16000000', 'mountain', false, '', 16, 6, 2023);
    createATour('Taij Hang', '7000000', 'mountain', false, '', 17, 6, 2023);
    createATour('Paris Capital', '9000000', 'city', false, '', 17, 6, 2023);
    createATour('Colosseum', '28000000', 'city', false, '', 19, 6, 2023);
    createATour('Los Cabos', '18000000', 'city', false, '', 19, 6, 2023);
    createATour('Santorini', '12000000', 'beach', false, '', 26, 6, 2023);
  }*/

  //Hàm đăng ký dữ liệu tourDetails lên Firebase
  void createTourDetail(
      String idTour,
      String placeTour,
      String timeStart,
      int startDay,
      int startMonth,
      int startYear,
      String imageTourDetails,
      String description,
      int dayEnd,
      String hotel,
      String priceFlightEconomy,
      String priceFlightBusiness) {
    final tourDetail = tourDetails(
        idTour: idTour,
        placeTour: placeTour,
        timeStart: timeStart,
        startDay: startDay,
        startMonth: startMonth,
        startYear: startYear,
        imageTourDetails: imageTourDetails,
        description: description,
        dayEnd: dayEnd,
        hotel: hotel,
        priceFlightEconomy: priceFlightEconomy,
        priceFlightBusiness: priceFlightBusiness);

    Future createTourDetails(tourDetails tourDetail) async {
      final docUser =
          FirebaseFirestore.instance.collection('TourDetails').doc();
      tourDetail.idTourDetails = docUser.id;

      final json = tourDetail.toJson();
      await docUser.set(json);
    }

    createTourDetails(tourDetail);
  }

  //Hàm đưa dữ liệu lên Firebase
  /*void createAllTourDetail() {
    createTourDetail(
        'Nhd7srL72oNncFxiIthz',
        'Bernese Oberland, Bern',
        '13:50',
        16,
        6,
        2023,
        'SwitzerlandDetails',
        textHelpers.textDetailsJungfrau,
        4,
        'Khách sạn: 4 sao',
        '7000000','1000000');
    createTourDetail(
        'SbRDwEwcYgcuxmYTehhL',
        'Rome, Italia',
        '14:20',
        19,
        6,
        2023,
        'RomeDetails',
        textHelpers.textDetailsColoseeum,
        5,
        'Khách sạn: 3 sao',
        '6000000','1100000');
    createTourDetail(
        'wvtz2gWH5JSD2SbqrgXS',
        'North Brazil',
        '6:00',
        14,
        6,
        2023,
        'CotaRicaDetails',
        textHelpers.textDetailsCotaRica,
        6,
        'Khách sạn: 5 sao',
        '5500000', '1200000');
    createTourDetail(
        'gLAdqipmIx6NEyCuUI6m',
        'Plaza Mexico',
        '8:30',
        19,
        6,
        2023,
        'MexicoDetails',
        textHelpers.textDetailsMexico,
        5,
        'Khách sạn: 4 sao', '8000000','1040000');
    createTourDetail(
        'SBDCHMgUWJwuq0O5FiIL',
        'North Prades, China',
        '8:30',
        17,
        6,
        2023,
        'Taij Hang Details',
        textHelpers.textDetailsChina,
        4,
        'Khách sạn: 6 sao','1000000','1250000');
    createTourDetail(
        '0OcwRPVBXh5jiq0irDQ0',
        'Carlsbad, San Marcos',
        '18:30',
        15,
        6,
        2023,
        'SeaBeachDetails',
        textHelpers.textDetailsSanDiego,
        4,
        'Khách sạn: 4 sao','7000000','8000000');
    createTourDetail(
        'RBMxsvSMnnVZz9xGuFnv',
        'Naviotar, Italy',
        '10:30',
        15,
        6,
        2023,
        'NavagioDetails',
        textHelpers.textDetailsNavagio,
        5,
        'Khách sạn: 5 sao','900000','1200000');
    createTourDetail( // 1
        'Efq4Gj39QUreThwVOSMw',
        'Thiga Island, Aegea',
        '12:30',
        15,
        6,
        2023,
        'SantoriniDetails',
        textHelpers.textDetailsSantorini,
        5,
        'Khách sạn: 4 sao','9600000','1100000');
    createTourDetail(
        'ybAO0F5euchxoBN5pUpu',
        'Île-de France',
        '4:30',
        17,
        6,
        2023,
        'ParisDetails',
        textHelpers.textDetailsParis,
        4,
        'Khách sạn: 4 sao','7000000','9000000');
    createTourDetail(
        'l9mogjPKYlPoeji2uccW',
        'Kyoto, Japan',
        '2:30',
        16,
        6,
        2023,
        'FujiSijuDetails',
        textHelpers.textDetailsFujiSiju,
        5,
        'Khách sạn: 4 sao','9000000','9900000');
  }*/

  TypeTours typeTours = TypeTours(refreshLayout: () {});
  SearchTours searchTours = SearchTours(
    refreshLayout: () {},
  );

  //Hàm bắt buộc class này phải dc reBuild
  void _refreshLayout() {
    setState(() {
      typeTours.setTypeTour();
    });
  }

  late String addressCurrent;
  late String idUserCurrent;

  late String path_to_images;
  late File imagesFile;
  late Image images;

  @override
  void initState() {
    super.initState();
    addressCurrent = widget.users.address;
    idUserCurrent = widget.users.idUser;
    path_to_images = widget.users.imageUser;
    imagesFile = File(path_to_images);
    images = Image.file(imagesFile);

    //createTours(); //Mở ra khi nào muốn add tất cả tour lên Firebase lại
    //createAllTourDetail(); //Mở ra khi nào muốn add tất cả tourDetails
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    //Viết hoa chữ cái đầu
    String capitalize(String s) =>
        s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                //Container Layout và Infor
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      height: 60,width: 60,
                      child: ClipOval(
                        child: Image.file(
                          imagesFile,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                        clipper: MyClipper(),
                      ),
                    ),
                    Padding( //Container Name,Address
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 230,height: 50,
                            child: AutoSizeText(
                              'Hi! ${widget.users.nameUser}',
                              maxFontSize: 27,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff111111)),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.locationDot,
                                  size: 20, color: Color(0xff6c757d)),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: 200,height: 30,
                                  child: AutoSizeText(
                                    widget.users.address,
                                    maxFontSize: 18,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2,
                                        height: 0,
                                        color: Color(0xff6c757d)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    StatefulBuilder( //Container BellYellow
                        builder: (BuildContext context, StateSetter setState) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BellNotification(
                                          users: idUserCurrent,
                                        )));
                          });
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.solidBell,
                          size: 35,
                          color: Color(0xfffdc500),
                        ),
                      );
                    })
                  ],
                ),
              ),
              //Container Search
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SearchTours(refreshLayout: _refreshLayout)),
              //3 block mountain, beach, city,
              TypeTours(refreshLayout: _refreshLayout),
              //Container Explorer
              Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 15, left: 7),
                  child: CustomText(
                      text: 'Khám phá',
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      height: 0,
                      color: Colors.black)),
              SizedBox(height: 10),
              //Container List Tours
              Container(
                  height: 430,
                  width: size.width,
                  child: StreamBuilder<List<aTour>>(
                    stream: readListTour(typeTours.checkTypeTours(),
                        capitalize(searchTours.checkSearchTour())),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final aTour = snapshot.data;
                        return ListView.builder(
                          itemCount: aTour!.length,
                          itemBuilder: (BuildContext context, int index) {
                            aTour[index].idUser = idUserCurrent;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VacationDetails(
                                            tour: aTour[index])));
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
            ],
          ),
        ),
      ),
    );
  }

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
