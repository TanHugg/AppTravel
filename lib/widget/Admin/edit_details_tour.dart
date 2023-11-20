import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/custom_snackbar.dart';
import '../../values/custom_text.dart';

class EditDetailsTour extends StatelessWidget {
  const EditDetailsTour({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        padding: EdgeInsets.only(left: 14, right: 20, top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 12, top: 35),
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
                      color: Color(0xff00b4d8),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 20),
                child: Text('sửa chi tiết',
                    style: GoogleFonts.lato(
                        fontSize: 45,
                        decoration: TextDecoration.none,
                        color: Colors.black87)),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 24, right: 20),
              child: Container(
                width: size.width,
                height: 650,
                child: SingleChildScrollView(
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Tên Tour",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Giá",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Ngày đi",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Tháng đi",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Năm đi",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Loại Tour",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Mô tả",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Loại khách sạn",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Địa chỉ Tour",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Giá vé máy bay hạng Phổ Thông",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Giá vé máy bay hạng Thương Gia",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Số ngày đi",
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        // controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: "Thời gian khởi hành",
                        ),
                      ),

                      //Nút Edit Profile
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 190), //Xem lại
                        child: SizedBox(
                            width: 230,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  CustomSnackbar.show(
                                      context, "Cập nhật thành công");
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffffd500),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: const CustomText(
                                    text: 'Cập nhật',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    height: 1.3))),
                      )
                    ],
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

InputDecoration decoration(String labelText) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white70)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: Colors.white70),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white70));
}
