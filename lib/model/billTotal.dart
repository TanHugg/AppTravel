class billTotal {
  String? idBill;
  String? idTour;
  String? idFlight;
  String? idUser;
  int? priceBill;
  String? dateTime;
  bool? checkBought;

  billTotal(
      {this.idBill = '',
      required this.idTour,
      required this.idFlight,
      required this.priceBill,
      required this.idUser,
      required this.dateTime,
      required this.checkBought});

  Map<String, dynamic> toJson() => {
        'idBill': idBill,
        'idTour': idTour,
        'idFlight': idFlight,
        'idUser': idUser,
        'priceBill': priceBill,
        'dateTime': dateTime,
        'checkBought': checkBought
      };

  //Lấy từ trên FirebaseStore xuống
  static billTotal fromJson(Map<String, dynamic> json) => billTotal(
        idBill: json['idBill'].toString(),
        idTour: json['idTour'].toString(),
        idFlight: json['idFlight'].toString(),
        idUser: json['idUser'].toString(),
        priceBill: json['priceBill'],
        dateTime: json['dateTime'],
        checkBought: json['checkBought']
      );
}
