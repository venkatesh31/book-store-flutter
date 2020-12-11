class User {
  int userId;
  String name;
  String userName;
  String password;


  User(
      {this.userId,
        this.name,
        this.userName,
        this.password,
       });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    password = json['password'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['password'] = this.password;
    
    return data;
  }
}