import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

String searchTour = '';

class SearchTours extends StatefulWidget {
  const SearchTours({Key? key, required this.refreshLayout}) : super(key: key);

  final VoidCallback refreshLayout; //Là function bên kia a

  @override
  State<SearchTours> createState() => _SearchToursState();

  String checkSearchTour() {
    return searchTour;
  }
}

class _SearchToursState extends State<SearchTours> {
  //Refresh lại layout
  void _listenRefresh() {
    widget.refreshLayout();
  }

  final searchTourController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 470,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xfff4f3ee)),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
                alignment: Alignment.center,
                width: 44,
                height: 50,
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 26,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Container(
              width: 220,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: searchTourController,
                style: TextStyle(
                  overflow: TextOverflow.visible,
                  fontSize: 23,
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    height: 1.2,
                     fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              width: 50,
              height: 30,
              padding: EdgeInsets.all(0), // đặt lề cho Container bằng 0
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  searchTour = searchTourController.text;
                  _listenRefresh();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfff4f3ee).withOpacity(0.6)),
                child: FaIcon(FontAwesomeIcons.arrowRight,
                    size: 25, color: Color(0xffd7e3fc)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
