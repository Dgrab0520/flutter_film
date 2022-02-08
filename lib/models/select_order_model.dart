class Select_Order {
  String user_id;
  String order_id;
  String user_token;
  String service_date;
  String skill;
  String service_area;
  String service_type;
  String service_size;
  String service_detail;
  String order_type;
  String dir_pro_id;
  String order_date;
  String pro_user_id;
  String com_name;
  String pro_skill;
  String area1;

  Select_Order(
      {required this.user_id,
      required this.order_id,
      required this.user_token,
      required this.service_date,
      required this.skill,
      required this.service_area,
      required this.service_type,
      required this.service_size,
      required this.service_detail,
      required this.order_type,
      required this.dir_pro_id,
      required this.order_date,
      required this.pro_user_id,
      required this.com_name,
      required this.pro_skill,
      required this.area1});

  factory Select_Order.fromJosn(Map<String, dynamic> json) {
    return Select_Order(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String,
      order_id: json['order_id'] == null ? "" : json['order_id'] as String,
      user_token:
          json['user_token'] == null ? "" : json['user_token'] as String,
      service_date:
          json['service_date'] == null ? "" : json['service_date'] as String,
      skill: json['skill'] == null ? "" : json['skill'] as String,
      service_area:
          json['service_area'] == null ? "" : json['service_area'] as String,
      service_type:
          json['service_type'] == null ? "" : json['service_type'] as String,
      service_size:
          json['service_size'] == null ? "" : json['service_size'] as String,
      service_detail: json['service_detail'] == null
          ? ""
          : json['service_detail'] as String,
      order_type:
          json['order_type'] == null ? "" : json['order_type'] as String,
      dir_pro_id:
          json['dir_pro_id'] == null ? "" : json['dir_pro_id'] as String,
      order_date:
          json['order_date'] == null ? "" : json['order_date'] as String,
      pro_user_id:
          json['pro_user_id'] == null ? "" : json['pro_user_id'] as String,
      com_name: json['com_name'] == null ? "" : json['com_name'] as String,
      pro_skill: json['pro_skill'] == null ? "" : json['pro_skill'] as String,
      area1: json['area1'] == null ? "" : json['area1'] as String,
    );
  }
}
