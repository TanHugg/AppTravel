class aTour {
  String idTour;
  String? nameTour;
  int? priceTour;
  bool isFavorite = false;
  String? idUser;

  aTour(
      {this.idTour = '',
      required this.nameTour,
      required this.priceTour,
      required this.isFavorite,
      required this.idUser});

  Map<String, dynamic> toJson() => {
    'idTour': idTour,
    'nameTour': nameTour,
    'price': priceTour,
    'isFavorite': isFavorite,
    'idUser': idUser
  };

  //Lấy từ trên FirebaseStore xuống
  static aTour fromJson(Map<String, dynamic> json) => aTour(
    idTour: json['idTour'].toString(),
    nameTour: json['nameTour'].toString(),
    priceTour: json['price'],
    isFavorite: json['isFavorite'],
    idUser: json['idUser'].toString(),
  );
}
