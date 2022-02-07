//전문가 마이페이지 보낸 견적서 목록 불러오기
class Estimate_Info{
  String order_id;
  String user_id;
  String pro_id;
  String estimate_detail;
  String estimate_date;

  Estimate_Info({required this.order_id, required this.user_id, required this.pro_id, required this.estimate_detail, required this.estimate_date});

  factory Estimate_Info.fromJson(Map<String, dynamic> json){
    return Estimate_Info(
      order_id: json['order_id'] as String,
      user_id: json['user_id'] as String,
      pro_id: json['pro_id'] as String,
      estimate_detail: json['estimate_detail'] as String,
      estimate_date: json['estimate_date'] as String,
    );
  }
}