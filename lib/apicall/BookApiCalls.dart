import 'dart:convert';

import 'package:book_store/request/LoginRequest.dart';
import 'package:book_store/response/BookResponse.dart';
import 'package:book_store/response/UserResponse.dart';
import 'package:book_store/utils/ParseHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class BookApiCalls{

  static Future<BookResponse> getBook() async {
    final String url = "http://192.168.29.227:8191/book/get" ;
    print(url);
    Response response = await get(url);

    print(response.statusCode);
    print(response.body);
    return compute(ParseHelper.parseBookResponse,response.body);
  }
}