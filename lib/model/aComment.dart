class aComment {
  String? idTour;
  String? idComment;
  String? nameUser;
  String? comment;
  int? score;

  aComment(
      {this.idTour = '',
      required this.idComment,
      required this.nameUser,
      required this.score,
      required this.comment,});

  Map<String, dynamic> toJson() => {
        'idTour': idTour,
        'idComment': idComment,
        'nameUser': nameUser,
        'score': score,
        'comment': comment,
      };

  //Lấy từ trên FirebaseStore xuống
  static aComment fromJson(Map<String, dynamic> json) => aComment(
        idTour: json['idTour'].toString(),
        idComment: json['idComment'].toString(),
        nameUser: json['nameUser'].toString(),
        score: json['score'],
        comment: json['comment'].toString(),
      );
}
