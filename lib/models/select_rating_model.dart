class Select_Rating {
  String pro_id;
  String user_id;
  String rating;
  String review;
  String review_date;

  Select_Rating(
      {required this.pro_id,
      required this.user_id,
      required this.rating,
      required this.review,
      required this.review_date});

  factory Select_Rating.fromJson(Map<String, dynamic> json) {
    return Select_Rating(
      pro_id: json['pro_id'] == null ? "" : json['pro_id'] as String,
      user_id: json['user_id'] == null ? "" : json['user_id'] as String,
      rating: json['rating'] == null ? "" : json['rating'] as String,
      review: json['review'] == null ? "" : json['review'] as String,
      review_date:
          json['review_date'] == null ? "" : json['review_date'] as String,
    );
  }
}
