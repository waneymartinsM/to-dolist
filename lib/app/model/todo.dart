import 'package:cloud_firestore/cloud_firestore.dart';

class TodoTaskModel {
  String idUser;
  String idTodoList;
  String task;
  String taskName;
  bool check;
  Timestamp? timestamp;

  TodoTaskModel({
    this.idUser = '',
    this.idTodoList = '',
    this.task = '',
    this.taskName = '',
    this.check = false,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUser': idUser,
      'idTodoList': idTodoList,
      'task': task,
      'taskName': taskName,
      'check': check,
      'timestamp': timestamp,
    };
    return map;
  }

  factory TodoTaskModel.fromMap(Map<dynamic, dynamic>? dados) {
    return TodoTaskModel(
      idUser: dados?['idUser'] ?? '',
      idTodoList: dados?['idTodoList'] ?? '',
      task: dados?['task'] ?? '',
      taskName: dados?['taskName'] ?? '',
      check: dados?['check'] ?? false,
      timestamp: dados?['timestamp'] ?? Timestamp.now(),
    );
  }
}
