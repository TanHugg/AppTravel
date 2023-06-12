import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/model/tourDetails.dart';
import 'package:travel_app/model/users.dart';
import 'package:travel_app/values/helpers.dart';
import 'package:travel_app/widget/HomePage/search_tours.dart';
import 'package:travel_app/widget/HomePage/type_tours.dart';
import '../values/custom_text.dart';
import '../widget/Details/vacation_details.dart';
import '../widget/HomePage/custom_tours.dart';
import 'package:intl/intl.dart';

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
  Stream<List<aTour>> readListTour(String typeTour, String searchTour) => (typeTour == '')
      ? FirebaseFirestore.instance.collection('Tour')
      .where('nameTour',isGreaterThanOrEqualTo: searchTour)
      .snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList())
      : FirebaseFirestore.instance
          .collection('Tour')
          .where('typeTour', isEqualTo: typeTour)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList());

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

  //Gọi hàm này để load lại Layout
  TypeTours typeTours = TypeTours(refreshLayout: () {});


  SearchTours searchTours = SearchTours(refreshLayout: () {},);

  //Hàm bắt buộc class này phải dc reBuild
  void _refreshLayout() {
    setState(() {
      typeTours.setTypeTour();
    });
  }

  late String addressCurrent;
  late String idUserCurrent;

  @override
  void initState() {
    super.initState();
    addressCurrent = widget.users.address;
    idUserCurrent = widget.users.idUser;
    //createTours(); //Mở ra khi nào muốn add tất cả tour lên Firebase lại
    //createAllTourDetail(); //Mở ra khi nào muốn add tất cả tourDetails
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 67, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                //Container Layout và Info
                child: Row(
                  children: <Widget>[
                    Container(
                      //Container Avata
                      width: 60,
                      height: 60,
                      decoration: ShapeDecoration(
                          shape: CircleBorder(
                              side:
                                  BorderSide(width: 2, color: Colors.white24))),
                      child: Image.asset(
                        'assets/images/avata.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      //Container Information
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hi! ${widget.users.nameUser}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff111111)),
                          ),
                          Row(
                            children: <Widget>[
                              FaIcon(FontAwesomeIcons.locationDot,
                                  size: 20, color: Color(0xff6c757d)),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CustomText(
                                    text: widget.users.address,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                    height: 0,
                                    color: Color(0xff6c757d)),
                              )
                            ],
                          ),
                        ],
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
              Padding(padding: EdgeInsets.only(top: 20), child: SearchTours(refreshLayout: _refreshLayout)),
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
                  height: 350,
                  width: size.width,
                  child: StreamBuilder<List<aTour>>(
                    stream: readListTour(typeTours.checkTypeTours(),searchTours.checkSearchTour()),
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

  static final formattedPrice = NumberFormat.currency(locale: 'vi_VN',symbol: 'đ');
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
