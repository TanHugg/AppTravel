class aFlight {
  String? idFlight;
  String? nameFlight;
  String? priceFlight;
  String? idTour;
  String? rank;


  aFlight(
      {this.idFlight = '',
      required this.nameFlight,
      required this.priceFlight,
      required this.idTour,
      required this.rank});

  Map<String, dynamic> toJson() => {
    'idFly': idFlight,
    'nameFlight': nameFlight,
    'price': priceFlight,
    'idTour': idTour,
    'rank': rank
  };

  //Lấy từ trên FirebaseStore xuống
  static aFlight fromJson(Map<String, dynamic> json) => aFlight(
    idFlight: json['idFly'].toString(),
    nameFlight: json['nameFlight'].toString(),
    priceFlight: json['price'].toString(),
    idTour: json['idTour'].toString(),
    rank: json['rank'].toString(),
  );
}
