import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/values/custom_text.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Text.rich(
              TextSpan(
                text: 'Your',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: Colors.black
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Likes',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      color: Colors.black87
                    )
                  )
                ]
              )
            ),

          ],
        ),
      ),
    );
  }
}
