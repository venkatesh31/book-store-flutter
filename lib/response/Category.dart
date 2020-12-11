class Category {
  int categoryId;
  String name;

  Category(
      {this.categoryId,
        this.name,
       });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    
    return data;
  }
}