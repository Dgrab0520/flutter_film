class Pro_Profile{
  String user_id;
  String skill;
  String com_name;
  String area1;
  String area2;
  String area3;
  String profile_img;



  Pro_Profile({required this.user_id, required this.skill, required this.com_name, required this.area1, required this.area2, required this.area3, required this.profile_img});

  factory Pro_Profile.fromJson(Map<String, dynamic> json){
    return Pro_Profile(
      user_id: json['user_id'] as String,
      skill: json['skill'] as String,
      com_name: json['com_name'] as String,
      area1: json['area1'] as String,
      area2: json['area2'] as String,
      area3: json['area3'] as String,
      profile_img: json['profile_img'] as String,
    );
  }
}