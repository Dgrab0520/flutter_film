class Order_ProList {
  String order_id;
  String user_id;
  String pro_id;
  String estimate_id;
  String estimate_date;
  String estimate_detail;
  String skill;
  String com_name;
  String area1;
  String profile_img;
  String token;

  Order_ProList({
    required this.order_id,
    required this.user_id,
    required this.pro_id,
    required this.estimate_id,
    required this.estimate_date,
    required this.estimate_detail,
    required this.skill,
    required this.com_name,
    required this.area1,
    required this.profile_img,
    required this.token,
  });

  factory Order_ProList.fromJson(Map<String, dynamic> json) {
    return Order_ProList(
      order_id: json['order_id'] as String,
      user_id: json['user_id'] as String,
      pro_id: json['pro_id'] as String,
      estimate_id: json['estimate_id'] as String,
      estimate_date: json['estimate_date'] as String,
      estimate_detail: json['estimate_detail'] as String,
      skill: json['skill'] as String,
      com_name: json['com_name'] as String,
      area1: json['area1'] as String,
      profile_img: json['profile_img'] as String,
      token: json['pro_token'] as String,
    );
  }
}
