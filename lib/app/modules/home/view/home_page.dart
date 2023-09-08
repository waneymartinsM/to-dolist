import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/modules/home/store/home_store.dart';
import 'package:todolist/app/modules/home/view/add_task_list.dart';
import 'package:todolist/app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore controller = Modular.get();

  @override
  void initState() {
    controller.recoverUserData();
    controller.searchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPurple,
      appBar: AppBar(
        title: Text(
          'LISTA DE TAREFAS',
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.bold, color: lightPurple),
        ),
        centerTitle: true,
        backgroundColor: purple,
        elevation: 2.0,
        iconTheme: const IconThemeData(color: lightPurple),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Modular.to.navigate('/login');
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Observer(
        builder: (_) => controller.loading
            ? const Center(child: CircularProgressIndicator(color: lightPurple))
            : controller.userTodoList.isEmpty
                ? Center(
                    child: Text("Sem Lista",
                        style: GoogleFonts.montserrat(
                            fontSize: 20, color: lightPurple)),
                  )
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (
                      OverscrollIndicatorNotification overscroll,
                    ) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: _buildToDoList()),
      ),
      floatingActionButton: _buildAddTask(context),
    );
  }

  Widget _buildAddTask(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        controller.manipulateText('');
        showDialog(
          context: context,
          builder: (_) => AddTaskList(
            action: 'Lista',
            controller: controller,
            hintText: 'Título da Tarefa',
          ),
        );
      },
      backgroundColor: mediumPurple,
      child: const Icon(Icons.add, size: 30, color: darkPurple),
    );
  }

  ListView _buildToDoList() {
    return ListView.builder(
      itemCount: controller.userTodoList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: lightPurple,
            child: _buildDeleteTask(index),
          ),
        );
      },
    );
  }

  Dismissible _buildDeleteTask(int index) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        controller.deleteList(
          controller.userTodoList[index],
        );
      },
      background: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xffCC0000),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Icon(Icons.delete_outline_outlined, color: Colors.white),
        ),
      ),
      key: ValueKey(controller.userTodoList.length),
      child: ListTile(
        title: Text(
          controller.userTodoList[index].name,
          style: GoogleFonts.montserrat(fontSize: 20),
        ),
        onTap: () {
          Modular.to.pushNamed("/home/todoList", arguments: {
            'name': controller.userTodoList[index].name,
            'idUser': controller.userTodoList[index].idUser,
          });
        },
      ),
    );
  }
}
