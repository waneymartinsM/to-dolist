import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todolist/app/model/list.dart';
import 'package:todolist/app/model/todo.dart';
import 'package:todolist/app/model/user.dart';
import 'package:todolist/app/modules/home/repository/home_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final HomeRepository _repository = HomeRepository();
  TextEditingController textController = TextEditingController();

  fetchTasks(Map dados) => _repository.todoList(descending, dados);

  @observable
  ObservableList<TodoListModel> userTodoList = ObservableList<TodoListModel>();

  @observable
  bool imported = false;

  @observable
  bool loading = false;

  @action
  searchList() async {
    loading = true;

    if (userModel.name.isNotEmpty) {
      TodoListModel listModel = TodoListModel();
      List<QueryDocumentSnapshot> list = [];
      list = await _repository.listData();

      for (var dados in list) {
        listModel = TodoListModel.fromMap(dados.data() as Map);

        if (userModel.idUser == listModel.idUser) {
          userTodoList.add(listModel);
        }
      }
      loading = false;
    } else {
      await recoverUserData();
      searchList();
    }
  }

  @observable
  bool descending = false;

  @action
  changeOrder(Map dados) {
    descending = !descending;
    fetchTasks(dados);
  }

  TodoTaskModel convertTodoList(DocumentSnapshot dados) {
    return TodoTaskModel.fromMap(dados.data() as Map);
  }

  @observable
  int count = 0;

  @action
  setCount(int value) => count = value;

  @action
  Future addList() async {
    if (userModel.idUser.isNotEmpty) {
      TodoListModel listModel = TodoListModel();
      listModel.name = textController.text;
      listModel.idUser = userModel.idUser;
      textController.text = '';

      _repository.addList(listModel);
      userTodoList.clear();
      searchList();
    } else {
      await recoverUserData();
    }
    Modular.to.pop();
  }

  void deleteList(TodoListModel listModel) {
    if (userModel.idUser == listModel.idUser) {
      _repository.deleteList(listModel);
    }
  }

  void addTask(TodoTaskModel taskModel) {
    taskModel.task = textController.text;
    taskModel.timestamp = Timestamp.now();
    textController.text = '';

    _repository.addTodoList(taskModel);
    Modular.to.pop();
  }

  void editTask(TodoTaskModel taskModel) {
    taskModel.task = textController.text;
    textController.text = "";
    _repository.editTodoList(taskModel);
    Modular.to.pop();
  }

  void deleteTask(TodoTaskModel taskModel) {
    _repository.deleteTodoList(taskModel);
  }

  void updateTodoList(TodoTaskModel taskModel) {
    _repository.updateTodoList(taskModel);
  }

  void manipulateText(String text) {
    textController.text = text;
  }

  @observable
  UserModel userModel = UserModel();

  @action
  recoverUserData() async {
    bool response = _repository.checkCurrentUser();
    if (response) {
      userModel = await _repository.recoverUserData();
    }
  }

  @action
  clearVariables() {
    userModel = UserModel.clean();
  }
}
