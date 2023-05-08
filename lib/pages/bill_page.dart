import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/values/custom_text.dart';

//Size ở page này còn lũng

class BillPage extends StatelessWidget {
  const BillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xffd9d9d9),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 120, right: 20),
            child: Container(
              width: size.width,
              height: size.height * 3 / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xffffffff)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                        text: 'Name: ',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        height: 1),
                    SizedBox(height: 5),
                    CustomText(
                        text: 'Number: ',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        height: 1),
                    SizedBox(height: 5),
                    CustomText(
                        text: 'Email: ',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        height: 1),
                    SizedBox(height: 20),
                    CustomText(
                        text: '1. Ticket Travel: ',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        height: 1),
                    SizedBox(height: 5),
                    CustomText(
                        text: '2. Ticket Flight: ',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.2,
                        height: 1),
                    SizedBox(height: 25),
                    CustomText(
                        text: 'Total: ',
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        height: 1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 65,
            left: 50,
            child: Text(
              'Bill',
              style: GoogleFonts.pacifico(
                  fontSize: 65,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            top: 625,
            left: 12,
            child: Container(
              width: 370,height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30,top: 15),
                    child: CustomText(
                        text: 'Total: ',
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        height: 1),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                        child: SizedBox(
                          width: 140,height: 60,
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Text('Pay',style: TextStyle(fontSize: 30),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )
                            ),),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: SizedBox(
                          width: 140,height: 60,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Close',style: TextStyle(fontSize: 25,color: Colors.black),),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.white,
                                side: BorderSide(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )
                            ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
