import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/values/custom_text.dart';
import 'package:travel_app/widget/ProfilePage/Custom_Information/MyClipper.dart';
import 'package:travel_app/widget/ProfilePage/auto_images_slider.dart';

import '../../model/users.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
          ),
          //Ảnh bìa
          Container(
            width: size.width,
            height: size.height * 1 / 4,
            child: AutoImagesSlider(),
          ),
          Positioned(
            left: 15,
            child: Row(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 22, top: 65),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      backgroundColor: Colors.black12,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeftLong,
                      size: 33,
                      color: Colors.white,
                    )),
              ),
            ]),
          ),
          //Hình tròn chứa hình
          Positioned(
            top: 110,
            left: 120,
            child: SizedBox(
              height: 170,width: 170,
              child: ClipOval(
                  child: Image(
                    image:AssetImage(
                        'assets/images/face_images/Face_1.jpg'),fit: BoxFit.cover,
                  ),
                  clipper: MyClipper(),
                ),
            ),
            ),
          Positioned(
              top: 295,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: <Widget>[
                      CustomProFile(size, 'Tên', user.nameUser),
                      SizedBox(height: 25),
                      CustomProFile(size, 'Email', user.email),
                      SizedBox(height: 25),
                      CustomProFile(size, 'Số điện thoại',
                          '0${user.numberPhone.toString()}'),
                      SizedBox(height: 25),
                      CustomProFile(size, 'Địa chỉ', user.address),
                    ],
                  )))
          //Column thông tin người dùng
        ],
      )),
    );
  }

  Widget CustomProFile(Size size, String profile_1, String profile_2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
            text: profile_1,
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            height: 1),
        SizedBox(height: 10),
        Container(
          width: size.width,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffced4da).withOpacity(0.5),
          ),
          child: CustomText(
              text: profile_2,
              color: Color(0xff495057),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              height: 1),
        )
      ],
    );
  }
}
