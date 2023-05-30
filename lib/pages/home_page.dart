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

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.users}) : super(key: key);

  final Users users;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user_auth = FirebaseAuth.instance.currentUser!;

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

  Stream<List<aTour>> readListTour(String typeTour) => (typeTour == '')
      ? FirebaseFirestore.instance.collection('Tour').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList())
      : FirebaseFirestore.instance
          .collection('Tour')
          .where('typeTour', isEqualTo: typeTour)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((doc) => aTour.fromJson(doc.data())).toList());

  //Hàm đăng ký Tour từ dữ liệu lên Firebase
  void createATour(String nameTour, int priceTour, String typeTour,
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
  void createTours() async {
    createATour('Cota Rica', 800, 'beach', false, '', 14, 6, 2023);
    createATour('San Diego', 1600, 'beach', false, '', 15, 6, 2023);
    createATour('Navagio', 1800, 'beach', false, '', 15, 6, 2023);
    createATour('Jungfrau Mountain', 1800, 'mountain', false, '', 16, 6, 2023);
    createATour('Fuji Siju', 600, 'mountain', false, '', 16, 6, 2023);
    createATour('Taij Hang', 700, 'mountain', false, '', 17, 6, 2023);
    createATour('Paris Capital', 900, 'city', false, '', 17, 6, 2023);
    createATour('Colosseum', 2800, 'city', false, '', 19, 6, 2023);
    createATour('Los Cabos', 1000, 'beach', false, '', 19, 6, 2023);
    createATour('Santorini', 1200, 'city', false, '', 26, 6, 2023);
  }

  void createTourDetail(
      String idTour,
      String placeTour,
      String timeStart,
      int startDay,
      int startMonth,
      int startYear,
      String imageTourDetails,
      String description) {
    final tourDetail = tourDetails(
        idTour: idTour,
        placeTour: placeTour,
        timeStart: timeStart,
        startDay: startDay,
        startMonth: startMonth,
        startYear: startYear,
        imageTourDetails: imageTourDetails,
        description: description);

    Future createTourDetails(tourDetails tourDetail) async {
      final docUser =
          FirebaseFirestore.instance.collection('TourDetails').doc();
      tourDetail.idTourDetails = docUser.id;

      final json = tourDetail.toJson();
      await docUser.set(json);
    }
    createTourDetails(tourDetail);
  }

  void createAllTourDetail() {
    createTourDetail('3djRBpyWwVmzoJOvXciI', 'Bernese Oberland, Bern', '13:50',
        16, 6, 2023, 'SwitzerlandDetails', textHelpers.textDetailsJungfrau);
    createTourDetail('4DWChCQcaIoCEPdrFuNp', 'Rome, Italia', '14:20', 19, 6,
        2023, 'SwitzerlandDetails', textHelpers.textDetailsColoseeum);
    createTourDetail('9PErBZSG7Q6zkJ2cjxFk', 'North Brazil', '6:00', 14, 6,
        2023, 'CotaRicaDetails', textHelpers.textDetailsCotaRica);
    createTourDetail('FNlOfuXdZu3NwK95gUke', 'Plaza Mexico', '8:30', 19, 6,
        2023, 'MexicoDetails', textHelpers.textDetailsMexico);
    createTourDetail('HqBctWHtOUMX6QhJHxxf', 'North Prades, China', '8:30', 17,
        6, 2023, 'Taij Hang Details', textHelpers.textDetailsChina);
    createTourDetail('RVvwPP6DzRGklL363RGW', 'Carlsbad, San Marcos', '18:30',
        15, 6, 2023, 'SeaBeachDetails', textHelpers.textDetailsSanDiego);
    createTourDetail('RmeN4de8tPfIBa5E7VkP', 'Naviotar, Italy', '10:30', 15, 6,
        2023, 'NavagioDetails', textHelpers.textDetailsNavagio);
    createTourDetail('T8MzTP74OtukBqOlxOUa', 'Thiga Island, Aegea', '12:30',
        15, 6, 2023, 'SeaBeachDetails', textHelpers.textDetailsSantorini);
    createTourDetail('Ub4UPmMrxZ7oOG88RZ5u', 'Île-de France', '4:30', 17, 6,
        2023, 'ParisDetails', textHelpers.textDetailsParis);
    createTourDetail('pS0Whurv8qLE20mOLAkG', 'Kyoto, Japan', '2:30', 16, 6,
        2023, 'FujiSijuDetails', textHelpers.textDetailsFujiSiju);
  }

  //Gọi hàm này để load lại Layout
  TypeTours typeTours = TypeTours(
    refreshLayout: () {},
  );

  //Hàm bắt buộc class này phải dc reBuild
  void _refreshLayout() {
    setState(() {});
  }

  late String addressCurrent;
  late String idUserCurrent;

  @override
  void initState() {
    super.initState();
    addressCurrent = widget.users.address;
    idUserCurrent = widget.users.idUser;
    // createTours(); //Khi nào cần ghi dữ liệu Tour lên Database thì mở cái này lên
    //createAllTourDetail();
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
              Padding(padding: EdgeInsets.only(top: 20), child: SearchTours()),
              //3 block mountain, beach, city,
              TypeTours(refreshLayout: _refreshLayout), //Hơi cấn cấn
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
              //Container Tours
              SizedBox(height: 10),
              Container(
                  height: 350,
                  width: size.width,
                  child: StreamBuilder<List<aTour>>(
                    stream: readListTour(typeTours.checkTypeTours()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final aTour = snapshot.data;
                        return ListView(
                          children: aTour!.map((item) {
                            return GestureDetector(
                              onTap: () {
                                print(// Xử lý sự kiện khi bấm vào phần tử
                                    'Bạn đã bấm vào phần tử: ${item.idTour}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        VacationDetails(
                                            tour: item)));
                              },
                              child: buildATour(item),
                            );
                          }).toList(),
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
          money: '\$ ${tour.priceTour}',
        ),
      );
}
