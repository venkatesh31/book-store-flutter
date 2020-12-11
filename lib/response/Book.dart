class Book {
  int bookId;
  String name;
  String description;
  int categoryId;
  String author;
  String publisher;
  String imageUrl;
  int price;


  Book(
      {this.bookId,
        this.name,
        this.description,
        this.categoryId,
        this.author,
        this.publisher,
        this.imageUrl,
        this.price,
       });

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    name = json['name'];
    description = json['description'];
    categoryId = json['categoryId'];
    author = json['author'];
    publisher = json['publisher'];
    imageUrl = json['imageUrl'];
    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['author'] = this.author;
    data['publisher'] = this.publisher;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;

    return data;
  }
}