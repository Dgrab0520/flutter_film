class Customer_List{
  String user_id;
  String service_date;
  String skill;
  String service_area;
  String service_type;
  String service_size;
  String service_detail;
  String order_date;
  String status;

  Customer_List({required this.user_id,
    required this.service_date,
    required this.skill,
    required this.service_area,
    required this.service_type,
    required this.service_size,
    required this.service_detail,
    required this.order_date,
    required this.status});

  factory Customer_List.fromJson(Map<String, dynamic> json){
    return Customer_List(
      user_id: json['user_id'] as String,
      service_date: json['service_date'] as String,
      skill: json['skill'] as String,
      service_area: json['service_area'] as String,
      service_type: json['service_type'] as String,
      service_size: json['service_size'] as String,
      service_detail: json['service_detail'] as String,
      order_date: json['order_date'] as String,
      status: json['status'] as String,
    );
  }
}