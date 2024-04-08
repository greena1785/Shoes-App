class UserData{
  String? id;
  String? name;
  String? email;
  String? password;

  UserData({this.id, this.name, this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'password' : this.password,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,

    );
  }
}
