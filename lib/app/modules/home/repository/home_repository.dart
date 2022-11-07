import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/app/core/firebase_const.dart';
import 'package:todolist/app/model/list.dart';
import 'package:todolist/app/model/todo.dart';
import 'package:todolist/app/model/user.dart';

class HomeRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  Stream<QuerySnapshot> todoList(bool descending, Map dados) {
    return dataBase
        .collection("task")
        .doc(dados["idUser"])
        .collection(dados["name"])
        .orderBy("timestamp", descending: descending)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot>> listData() async {
    List<QueryDocumentSnapshot> list = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await dataBase.collection("list").get();

    for (var dados in snapshot.docs) {
      list.add(dados);
    }
    return list;
  }

  void addList(TodoListModel list) {
    list.idList = dataBase.collection("list").doc().id;
    dataBase.collection("list").doc(list.idList).set(list.toMap());
  }

  void deleteList(TodoListModel list) {
    dataBase.collection("list").doc(list.idList).delete();
  }

  void addTodoList(TodoTaskModel todo) {
    String idDoc = dataBase.collection("task").doc().id;
    todo.idTodoList = idDoc;
    dataBase
        .collection("task")
        .doc(todo.idUser)
        .collection(todo.taskName)
        .doc(idDoc)
        .set(todo.toMap());
  }

  void editTodoList(TodoTaskModel todo) {
    dataBase
        .collection("task")
        .doc(todo.idUser)
        .collection(todo.taskName)
        .doc(todo.idTodoList)
        .update(todo.toMap());
  }

  void deleteTodoList(TodoTaskModel todo) {
    dataBase
        .collection("task")
        .doc(todo.idUser)
        .collection(todo.taskName)
        .doc(todo.idTodoList)
        .delete();
  }

  void updateTodoList(TodoTaskModel todo) {
    dataBase
        .collection("task")
        .doc(todo.idUser)
        .collection(todo.taskName)
        .doc(todo.idTodoList)
        .update({"check": todo.check});
  }

  Future recoverUserData() async {
    User user = _auth.currentUser!;
    UserModel userModel = UserModel();
    DocumentSnapshot snapshot =
        await dataBase.collection(FirebaseConst.usuarios).doc(user.uid).get();
    userModel = UserModel.fromMap(snapshot.data() as Map);
    return userModel;
  }

  bool checkCurrentUser() {
    User? user = _auth.currentUser;
    return user != null ? true : false;
  }
}
