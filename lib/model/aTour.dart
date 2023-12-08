class aTour {
  String? idTour;
  String? nameTour;
  String? priceTour;
  bool? isFavorite;
  String? idUser;
  int? startDay;
  int? startMonth;
  int? startYear;
  String? typeTour;

  aTour(
      {this.idTour = '',
      required this.nameTour,
      required this.priceTour,
      required this.typeTour,
      this.isFavorite = false,
      required this.idUser,
      required this.startDay,
      required this.startMonth,
      required this.startYear});

  Map<String, dynamic> toJson() => {
        'idTour': idTour,
        'nameTour': nameTour,
        'price': priceTour,
        'typeTour': typeTour,
        'startDay': startDay,
        'startMonth': startMonth,
        'startYear': startYear,
        'isFavorite': isFavorite,
        'idUser': idUser
      };

  //Lấy từ trên FirebaseStore xuống
  static aTour fromJson(Map<String, dynamic> json) => aTour(
        idTour: json['idTour'].toString(),
        nameTour: json['nameTour'].toString(),
        priceTour: json['price'].toString(),
        typeTour: json['typeTour'],
        isFavorite: json['isFavorite'],
        idUser: json['idUser'].toString(),
        startDay: json['startDay'],
        startMonth: json['startMonth'],
        startYear: json['startYear'],
      );
}
