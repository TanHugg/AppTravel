class feedBack {
  String? idFeedBack;
  String? idUser;
  String? feedBackContent;
  String? dateTimeFeedBack;

  feedBack(
      {this.idFeedBack = '',
        required this.feedBackContent,
        required this.dateTimeFeedBack,
      required this.idUser});

  Map<String, dynamic> toJson() => {
    'idFeedBack': idFeedBack,
    'feedBackContent': feedBackContent,
    'dateTimeFeedBack': dateTimeFeedBack,
    'idUser': idUser,
  };

  //Lấy từ trên FirebaseStore xuống
  static feedBack fromJson(Map<String, dynamic> json) => feedBack(
    idFeedBack: json['idFeedBack'].toString(),
    idUser: json['idUser'].toString(),
    feedBackContent: json['feedBackContent'].toString(),
    dateTimeFeedBack: json['dateTimeFeedBack'].toString(),
  );
}
