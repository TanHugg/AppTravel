class aFlight {
  String? idFlight;
  String? nameFlight;
  int? priceFlight;
  String? idTour;

  aFlight(
      {this.idFlight = '',
      required this.nameFlight,
      required this.priceFlight,
      required this.idTour});

  Map<String, dynamic> toJson() => {
    'idFly': idFlight,
    'nameFlight': nameFlight,
    'price': priceFlight,
    'idTour': idTour
  };

  //Lấy từ trên FirebaseStore xuống
  static aFlight fromJson(Map<String, dynamic> json) => aFlight(
    idFlight: json['idFly'].toString(),
    nameFlight: json['nameFlight'].toString(),
    priceFlight: json['price'],
    idTour: json['idTour'].toString(),
  );
}
