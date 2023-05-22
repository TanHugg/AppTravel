import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late String idUser;
  late String nameUser;
  late int numberPhone;
  late String address;
  late String email;

  Users(
      {this.idUser = '',
      required this.nameUser,
      required this.numberPhone,
      required this.address,
      required this.email});

  //Viết từ code lên FirebaseStore
  Map<String, dynamic> toJson() => {
        'id': idUser,
        'name': nameUser,
        'numberPhone': numberPhone,
        'address': address,
        'email': email
      };

  //Lấy từ trên FirebaseStore xuống
  static Users fromJson(Map<String, dynamic> json) => Users(
        idUser: json['id'].toString(),
        nameUser: json['name'].toString(),
        numberPhone: json['numberPhone'],
        address: json['address'].toString(),
        email: json['email'].toString(),
      );
}
