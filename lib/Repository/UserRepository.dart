import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:flutter_session/flutter_session.dart';

class UserRepository {
  Dio _dio = Dio();

  Future<User> login(String email, String password) async {
    try {
      Map<String, dynamic> userLogin = {"email": email, "password": password};
      var response = await _dio.post("http://localhost:3000/login/",
          data: userLogin,
          options: Options(headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Credentials":
                true, // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"
          }));
      if (response.statusCode == 200) {
        print("dentro if 200");
        // print(response.data);
        User user = User.fromJson(response.data);
        await FlutterSession().set("user", user);
        await FlutterSession().set("token", user.token);
        return user;
      } else
        print("fora if 200");

      return User();
    } catch (e) {
      print(e);
    }
  }

  Future<List<User>> listAllUsers() async {
    String token = await FlutterSession().get("token");
    Response response = await _dio.get("http://localhost:3000/user",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    List<User> users = (response.data as List).map((item) {
      return User.fromJson(item);
    }).toList();
    return users;
  }

  Future<User> getByID(id) async {
    User user = await FlutterSession().get("user");
    String token = user.token;
    Response response = await _dio.get("http://localhost:3000/users/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}));
    return User.fromJson(response.data);
  }

  Future<User> create(Map<String, dynamic> user) async {
    Response response = await _dio.post("http://slocalhost:3000", data: user);
    if (response.statusCode == 200) return User.fromJson(response.data);
  }
}
