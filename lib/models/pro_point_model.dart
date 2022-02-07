class Pro_Point{
  String user_id;
  String point_info;
  String point_detail;
  String total_point;
  String date;

  Pro_Point({required this.user_id, required this.point_info, required this.point_detail, required this.total_point, required this.date});

  factory Pro_Point.fromJson(Map<String, dynamic> json){
    return Pro_Point(
      user_id: json['user_id'] as String,
      point_info: json['point_info'] as String,
      point_detail: json['point_detail'] as String,
      total_point: json['total_point'] as String,
      date: json['date'] as String,
    );
  }
}