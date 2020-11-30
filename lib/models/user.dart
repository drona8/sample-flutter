import 'model.dart';

class User extends Model{
  String uid;
  String firstName;
  String lastName;
  String email;
  String password;
  String type;
  String imageUrl;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.type,
    this.imageUrl,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return User(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      password: data['password'],
      type: data['type'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonUser = new Map<String, dynamic>();
    jsonUser['firstName'] = this.firstName.trim();
    jsonUser['lastName'] = this.lastName.trim();
    jsonUser['email'] = this.email.trim();
    jsonUser['password'] = this.password.trim();
    jsonUser['type'] = this.type;
    jsonUser['imageUrl'] = this.imageUrl;
    return jsonUser;
  }
}