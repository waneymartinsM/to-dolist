class UserModel {
  String idUser;
  String name;
  String email;
  String password;

  UserModel({
    this.idUser = '',
    this.name = '',
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUser': idUser,
      'name': name,
      'email': email,
      'password': password,
    };
    return map;
  }

  factory UserModel.fromMap(Map<dynamic, dynamic>? dados) {
    return UserModel(
      idUser: dados?['uid'] ?? '',
      name: dados?['name'] ?? '',
      email: dados?['email'] ?? '',
      password: dados?['password'] ?? '',
    );
  }

  factory UserModel.clean() {
    return UserModel(
      idUser: '',
      name: '',
      email: '',
    );
  }
}
