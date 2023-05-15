
class Users{
  late String idUser;
  late String nameUser;
  late int numberPhone;
  late String address;
  late String email;

  Users({this.idUser = '',
      required this.nameUser,
      required this.numberPhone,
      required this.address,
      required this.email});

  Map<String,dynamic> toJson() =>{
    'id': idUser,
    'name': nameUser,
    'numberPhone': numberPhone,
    'address': address,
    'email': email
  };
}