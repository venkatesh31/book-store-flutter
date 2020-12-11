import 'dart:convert';

import 'package:book_store/response/BookResponse.dart';
import 'package:book_store/response/UserResponse.dart';

class ParseHelper{

  static UserResponse parseUserResponse( String responseBody) {
    print(responseBody);
    final jsonResponse = json.decode(responseBody);
    return new UserResponse.fromJson(jsonResponse);
  }

  static BookResponse parseBookResponse( String responseBody) {
    print(responseBody);
    final jsonResponse = json.decode(responseBody);
    return new BookResponse.fromJson(jsonResponse);
  }


}