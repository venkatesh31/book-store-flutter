import 'dart:convert';

import 'package:book_store/request/LoginRequest.dart';
import 'package:book_store/response/UserResponse.dart';
import 'package:book_store/utils/ParseHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class UserApiCalls{

  static Future<UserResponse> login(LoginRequest loginRequest,) async {
    final String url = "http://192.168.29.227:8191/user/login" ;
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    Response response = await post(url,body: json.encode(loginRequest.toJson()),headers: headers);

    print(response.statusCode);
    print(response.body);
    return compute(ParseHelper.parseUserResponse,response.body);
  }
}