class Select_Noti{
  String notice_title;
  String notice_content;
  String notice_img;
  String status;
  String notice_registerDate;

  Select_Noti({required this.notice_title, required this.notice_content, required this.notice_img, required this.status, required this.notice_registerDate});

  factory Select_Noti.fromJson(Map<String, dynamic> json){
    return Select_Noti(
      notice_title: json['notice_title'] as String,
      notice_content: json['notice_content'] as String,
      notice_img: json['notice_img'] as String,
      status: json['status'] as String,
      notice_registerDate: json['notice_registerDate'] as String,
    );
  }
}