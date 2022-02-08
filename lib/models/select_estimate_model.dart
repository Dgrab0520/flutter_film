class Select_Estimate {
  String order_id;
  String estimate_id;
  String user_id;
  String pro_id;
  String estimate_detail;
  String count;

  Select_Estimate({
    required this.order_id,
    required this.estimate_id,
    required this.user_id,
    required this.pro_id,
    required this.estimate_detail,
    required this.count,
  });

  factory Select_Estimate.fromJson(Map<String, dynamic> json) {
    return Select_Estimate(
      order_id: json['order_id'] as String,
      estimate_id:
          json['estimate_id'] == null ? "" : json['estimate_id'] as String,
      user_id: json['user_id'] as String,
      pro_id: json['pro_id'] as String,
      estimate_detail: json['estimate_detail'] as String,
      count: json['count'] == null ? "" : json['count'] as String,
    );
  }
}
