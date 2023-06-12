import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    //Size size = MediaQuery.of(context).size * 0.8;
    return Container(
        width: 470,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xfff4f3ee)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Container(
                  alignment: Alignment.center,
                  width: 44,
                  height: 50,
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 22,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13, bottom: 3, top: 11),
              child: Container(
                width: 170,
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
                      hintText: 'Tìm kiếm', border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                width: 55,
                height: 35,
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
                  onPressed: (){
                    searchTour = searchTourController.text;
                    _listenRefresh();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfff4f3ee).withOpacity(0.6)
                  ),
                  child: FaIcon(FontAwesomeIcons.arrowRight,size: 25,color: Color(0xffd7e3fc)),
                ),
              ),
            )
          ],
        ),
    );
  }
}
