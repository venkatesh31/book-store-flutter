
import 'package:book_store/response/Book.dart';
import 'package:book_store/response/Category.dart';
import 'package:book_store/response/User.dart';

class BookData{
  List<Book> books;
  Category category;

  BookData({this.books,this.category});

  BookData.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = new List<Book>();
      json['books'].forEach((v) {
        books.add(new Book.fromJson(v));
      });
    }
    category =
    json['category'] != null ? new Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }

    return data;
  }
}