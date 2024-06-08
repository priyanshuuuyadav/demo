import 'dart:convert';
import 'package:untitled1/models/user_model.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static Uri userApi = Uri.parse('http://dummyjson.com/users');

  static Future<List<User>> getAllUsers() async {
    var response = await http.get(userApi);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> a = data['users'];
      return a.map((e) => User.fromJson(e)).toList();
    } else {
      return <User>[];
    }
  }
}
