import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/home/view/home_page.dart';
import 'package:todolist/app/modules/home/view/todo_list.dart';
import '../store/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/todoList', child: (_, args) => TodoList(taskData: args.data)),
  ];
}
