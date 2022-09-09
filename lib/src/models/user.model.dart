class UserModel {
  int? id;
  String? username;
  String? email;

  UserModel({this.id, this.username, this.email});

  static List<UserModel> fromJsonList(List<dynamic> json) => json.map((i) => fromJson(i)).toList();

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(id: json["id"] as int, username: json["username"] as String, email: json["email"] as String);
  }
}
