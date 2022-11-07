class TodoListModel {
  String idUser;
  String name;
  String idList;

  TodoListModel({
    this.idUser = '',
    this.name = '',
    this.idList = '',
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUser': idUser,
      'name': name,
      'idList': idList,
    };
    return map;
  }

  factory TodoListModel.fromMap(Map<dynamic, dynamic>? dados) {
    return TodoListModel(
      idUser: dados?['idUser'] ?? '',
      name: dados?['name'] ?? '',
      idList: dados?['idList'] ?? '',
    );
  }
}
