class Customer_List {
  String user_id;
  String service_date;
  String skill;
  String service_area;
  String service_type;
  String service_size;
  String service_detail;
  String order_date;
  String status;
  String orderId;

  Customer_List({
    required this.user_id,
    required this.service_date,
    required this.skill,
    required this.service_area,
    required this.service_type,
    required this.service_size,
    required this.service_detail,
    required this.order_date,
    required this.status,
    required this.orderId,
  });

  factory Customer_List.fromJson(Map<String, dynamic> json) {
    return Customer_List(
      user_id: json['user_id'] == null ? "" : json['user_id'] as String,
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
      order_date:
          json['order_date'] == null ? "" : json['order_date'] as String,
      status: json['status'] == null ? "" : json['status'] as String,
      orderId: json['order_id'] == null ? "" : json['order_id'] as String,
    );
  }
}
