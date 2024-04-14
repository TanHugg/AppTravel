class aComment {
  String? idTour;
  String? nameUser;
  String? comment;

  aComment(
      {this.idTour = '',
      required this.nameUser,
      required this.comment,});

  Map<String, dynamic> toJson() => {
        'idTour': idTour,
        'nameUser': nameUser,
        'comment': comment,
      };

  //Lấy từ trên FirebaseStore xuống
  static aComment fromJson(Map<String, dynamic> json) => aComment(
        idTour: json['idTour'].toString(),
        nameUser: json['nameUser'].toString(),
        comment: json['comment'].toString(),
      );
}
