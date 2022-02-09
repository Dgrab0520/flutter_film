class Pro_Select {
  String user_id;
  String introduce;
  String basic;
  String company;
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;
  String com_name;
  String profile_img;
  String pro_token;

  Pro_Select({
    required this.user_id,
    required this.introduce,
    required this.basic,
    required this.company,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.com_name,
    required this.profile_img,
    required this.pro_token,
  });

  factory Pro_Select.fromJson(Map<String, dynamic> json) {
    return Pro_Select(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String,
      introduce: json['introduce'] == null ? "" : json['introduce'] as String,
      basic: json['basic'] == null ? "" : json['basic'] as String,
      company: json['company'] == null ? "" : json['company'] as String,
      img1: json['img1'] == null ? "" : json['img1'] as String,
      img2: json['img2'] == null ? "" : json['img2'] as String,
      img3: json['img3'] == null ? "" : json['img3'] as String,
      img4: json['img4'] == null ? "" : json['img4'] as String,
      img5: json['img5'] == null ? "" : json['img5'] as String,
      com_name: json['com_name'] == null ? "" : json['com_name'] as String,
      profile_img:
          json['profile_img'] == null ? "" : json['profile_img'] as String,
      pro_token: json['pro_token'] == null ? "" : json['pro_token'] as String,
    );
  }
}
