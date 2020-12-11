
import 'package:book_store/response/Book.dart';
import 'package:book_store/response/Category.dart';
import 'package:book_store/response/User.dart';

class UserResponse{
  User recordinfo;

  UserResponse({this.recordinfo});

  UserResponse.fromJson(Map<String, dynamic> json) {
    recordinfo =
    json['recordinfo'] != null ? new User.fromJson(json['recordinfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordinfo != null) {
      data['recordinfo'] = this.recordinfo.toJson();
    }
    return data;
  }
}