class Chat {
  int id;
  String estimateId;
  String estimate;
  String image;
  String text;
  String isPro;
  String pro_check;
  String user_check;
  String createAt;

  Chat({
    required this.id,
    required this.estimateId,
    required this.estimate,
    required this.text,
    required this.image,
    required this.isPro,
    required this.pro_check,
    required this.user_check,
    required this.createAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: int.parse(json['id']),
      estimateId: json['estimateId'] == null ? "" : json['estimateId'] as String,
      estimate: json['estimate'] == null ? "" : json['estimate'] as String,
      text: json['text'] == null ? "" : json['text'] as String,
      image: json['image'] == null ? "" : json['image'] as String,
      isPro: json['isPro'] == null ? "" : json['isPro'] as String,
      pro_check: json['pro_check'] == null ? "" : json['pro_check'] as String,
      user_check: json['user_check'] == null ? "" : json['user_check'] as String,
      createAt: json['createAt'] == null ? "" : json['createAt'] as String,
    );
  }
}
