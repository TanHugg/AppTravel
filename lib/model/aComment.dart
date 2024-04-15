class aComment {
  String? idTour;
  String? idComment;
  String? nameUser;
  String? comment;

  aComment(
      {this.idTour = '',
      required this.idComment,
      required this.nameUser,
      required this.comment,});

  Map<String, dynamic> toJson() => {
        'idTour': idTour,
        'idComment': idComment,
        'nameUser': nameUser,
        'comment': comment,
      };

  //Lấy từ trên FirebaseStore xuống
  static aComment fromJson(Map<String, dynamic> json) => aComment(
        idTour: json['idTour'].toString(),
        idComment: json['idComment'].toString(),
        nameUser: json['nameUser'].toString(),
        comment: json['comment'].toString(),
      );
}
