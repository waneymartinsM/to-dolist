// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$userTodoListAtom =
      Atom(name: 'HomeStoreBase.userTodoList', context: context);

  @override
  ObservableList<TodoListModel> get userTodoList {
    _$userTodoListAtom.reportRead();
    return super.userTodoList;
  }

  @override
  set userTodoList(ObservableList<TodoListModel> value) {
    _$userTodoListAtom.reportWrite(value, super.userTodoList, () {
      super.userTodoList = value;
    });
  }

  late final _$importedAtom =
      Atom(name: 'HomeStoreBase.imported', context: context);

  @override
  bool get imported {
    _$importedAtom.reportRead();
    return super.imported;
  }

  @override
  set imported(bool value) {
    _$importedAtom.reportWrite(value, super.imported, () {
      super.imported = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'HomeStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$descendingAtom =
      Atom(name: 'HomeStoreBase.descending', context: context);

  @override
  bool get descending {
    _$descendingAtom.reportRead();
    return super.descending;
  }

  @override
  set descending(bool value) {
    _$descendingAtom.reportWrite(value, super.descending, () {
      super.descending = value;
    });
  }

  late final _$countAtom = Atom(name: 'HomeStoreBase.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$userModelAtom =
      Atom(name: 'HomeStoreBase.userModel', context: context);

  @override
  UserModel get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  late final _$searchListAsyncAction =
      AsyncAction('HomeStoreBase.searchList', context: context);

  @override
  Future searchList() {
    return _$searchListAsyncAction.run(() => super.searchList());
  }

  late final _$addListAsyncAction =
      AsyncAction('HomeStoreBase.addList', context: context);

  @override
  Future<dynamic> addList() {
    return _$addListAsyncAction.run(() => super.addList());
  }

  late final _$recoverUserDataAsyncAction =
      AsyncAction('HomeStoreBase.recoverUserData', context: context);

  @override
  Future recoverUserData() {
    return _$recoverUserDataAsyncAction.run(() => super.recoverUserData());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic changeOrder(Map<dynamic, dynamic> dados) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeOrder');
    try {
      return super.changeOrder(dados);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCount(int value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setCount');
    try {
      return super.setCount(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearVariables() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.clearVariables');
    try {
      return super.clearVariables();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userTodoList: ${userTodoList},
imported: ${imported},
loading: ${loading},
descending: ${descending},
count: ${count},
userModel: ${userModel}
    ''';
  }
}
