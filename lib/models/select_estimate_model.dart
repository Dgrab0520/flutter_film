class Select_Estimate {
  String order_id;
  String estimate_id;
  String user_id;
  String pro_id;
  String com_name;
  String estimate_detail;
  String estimate_date;
  String count;
  String chat;
  String createAt;
  String token;

  Select_Estimate({
    required this.order_id,
    required this.estimate_id,
    required this.user_id,
    required this.pro_id,
    required this.com_name,
    required this.estimate_detail,
    required this.estimate_date,
    required this.count,
    required this.chat,
    required this.createAt,
    required this.token,
  });

  factory Select_Estimate.fromJson(Map<String, dynamic> json) {
    return Select_Estimate(
      order_id: json['order_id'] as String,
      estimate_id:
          json['estimate_id'] == null ? "" : json['estimate_id'] as String,
      user_id: json['user_id'] as String,
      pro_id: json['pro_id'] as String,
      com_name: json['com_name'] == null ? "" : json['com_name'] as String,
      estimate_detail: json['estimate_detail'] as String,
      estimate_date:
          json['estimate_date'] == null ? "" : json['estimate_date'] as String,
      count: json['count'] == null ? "" : json['count'] as String,
      chat: json['chat'] == null ? " " : json['chat'] as String,
      createAt: json['createAt'] == null ? " " : json['createAt'] as String,
      token: json['token'] == null ? " " : json['token'] as String,
    );
  }
}
