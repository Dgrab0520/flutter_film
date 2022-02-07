class ProToken{
  String id;
  String pro_token;

  ProToken({
    required this.id,
    required this.pro_token,
  });

  factory ProToken.fromJson(Map<String, dynamic> json){
    return ProToken(
      id: json['id'] as String,
      pro_token: json['pro_token'] as String,
    );
  }
}