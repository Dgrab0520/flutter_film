class User_Check {
  String user_id;
  String user_pw;
  String skill;
  String user_email;
  String phone_number;
  String com_name;
  String com_no;
  String area1;
  String area2;
  String area3;
  String register_date;
  String profile_img;

  User_Check(
      {required this.user_id,
      required this.user_pw,
      required this.skill,
      required this.user_email,
      required this.phone_number,
      required this.com_name,
      required this.com_no,
      required this.area1,
      required this.area2,
      required this.area3,
      required this.register_date,
      required this.profile_img});

  factory User_Check.fromJson(Map<String, dynamic> json) {
    return User_Check(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String,
      user_pw: json['user_pw'] == null ? "" : json['user_pw'] as String,
      skill: json['skill'] == null ? "" : json['skill'] as String,
      user_email:
          json['user_email'] == null ? "" : json['user_email'] as String,
      phone_number:
          json['phone_number'] == null ? "" : json['phone_number'] as String,
      com_name: json['com_name'] == null ? "" : json['com_name'] as String,
      com_no: json['com_no'] == null ? "" : json['com_no'] as String,
      area1: json['area1'] == null ? "" : json['area1'] as String,
      area2: json['area2'] == null ? "" : json['area2'] as String,
      area3: json['area3'] == null ? "" : json['area3'] as String,
      register_date:
          json['register_date'] == null ? "" : json['register_date'] as String,
      profile_img:
          json['profile_img'] == null ? "" : json['profile_img'] as String,
    );
  }
}
