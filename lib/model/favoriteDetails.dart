class FavoriteDetails{
  String? idFavoriteDetails;
  String? idUser;
  String? idTour;
  bool? favorite;

  FavoriteDetails({this.idFavoriteDetails = '',required this.idUser,required this.idTour,required this.favorite});

  Map<String, dynamic> toJson() => {
    'idFavoriteDetails': idFavoriteDetails,
    'idUser': idUser,
    'idTour': idTour,
    'favorite': favorite,
  };

  //Lấy từ trên FirebaseStore xuống
  static FavoriteDetails fromJson(Map<String, dynamic> json) => FavoriteDetails(
    idFavoriteDetails: json['idFavoriteDetails'].toString(),
    idUser: json['idUser'].toString(),
    idTour: json['idTour'].toString(),
    favorite: json['favorite']
  );
}