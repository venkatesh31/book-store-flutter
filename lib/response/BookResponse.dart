
import 'package:book_store/response/BookData.dart';
import 'package:book_store/response/User.dart';

class BookResponse{
  List<BookData> data;

  BookResponse({this.data});

  BookResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BookData>();
      json['data'].forEach((v) {
        data.add(new BookData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}