class Chat {
  int id;
  String estimateId;
  String estimate;
  String image;
  String text;
  String isPro;
  String createAt;

  Chat({
    required this.id,
    required this.estimateId,
    required this.estimate,
    required this.text,
    required this.image,
    required this.isPro,
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
      createAt: json['createAt'] == null ? "" : json['createAt'] as String,
    );
  }
}
