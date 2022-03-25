import 'package:http/http.dart' as http;

class RegisterRating_Data {
  static const ROOT = "http://211.110.1.58/film_rating.php";
  static const _ADD_RATING_ACTION = "ADD_RATING";

  static Future<String> addRating(
      String pro_id, String user_id, String rating, String review) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_RATING_ACTION;
      map['pro_id'] = pro_id;
      map['user_id'] = user_id;
      map['rating'] = rating;
      map['review'] = review;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Register Rating Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
