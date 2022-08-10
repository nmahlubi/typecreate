// @dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class userApi {
  String apis =
      "https://reqres.in/api/users?page=2";

  Future<List<User>> fetchUser() async {
    final response = await http
        .get(Uri.parse(apis), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);
      List lists = parsed;
      return lists.map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user');
    }
  }
}