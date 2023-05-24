class billTotal {
  String? idBill;
  String? idTour;
  String? idFlight;
  String? idUser;
  int? priceBill;

  billTotal(
      {this.idBill = '',
      required this.idTour,
      required this.idFlight,
      required this.priceBill,
      required this.idUser});

  Map<String, dynamic> toJson() => {
        'idBill': idBill,
        'idTour': idTour,
        'idFlight': idFlight,
        'idUser': idUser,
        'priceBill': priceBill,
      };

  //Lấy từ trên FirebaseStore xuống
  static billTotal fromJson(Map<String, dynamic> json) => billTotal(
        idBill: json['idBill'].toString(),
        idTour: json['idTour'].toString(),
        idFlight: json['idFlight'].toString(),
        idUser: json['idUser'].toString(),
        priceBill: json['priceBill'],
      );
}
