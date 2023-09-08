import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/model/todo.dart';
import 'package:todolist/app/modules/home/store/home_store.dart';
import 'package:todolist/app/modules/home/view/add_task_list.dart';
import 'package:todolist/app/utils/colors.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    Key? key,
    required this.taskData,
  }) : super(key: key);

  final Map taskData;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final HomeStore controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPurple,
      appBar: AppBar(
        title: Text(
          widget.taskData['name'],
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: lightPurple,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: lightPurple),
        backgroundColor: purple,
        elevation: 2.0,
        actions: [
          _buildChangeOrder(),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: _buildAddTask(context),
    );
  }

  FloatingActionButton _buildAddTask(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        controller.manipulateText('');
        TodoTaskModel taskModel = TodoTaskModel();
        taskModel.idUser = widget.taskData['idUser'];
        taskModel.taskName = widget.taskData['name'];
        showDialog(
            context: context,
            builder: (_) => AddTaskList(
                  action: "Adicionar",
                  controller: controller,
                  taskModel: taskModel,
                ));
      },
      backgroundColor: mediumPurple,
      child: const Icon(Icons.add, size: 30, color: darkPurple),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.fetchTasks(widget.taskData),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: lightPurple,
              child: Center(
                child: Text("Ocorreu um erro ao carregar lista!",
                    style: GoogleFonts.montserrat()),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: purple));
          } else {
            return NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView.separated(
                separatorBuilder: (_, index) =>
                    const Divider(height: 10, color: purple),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  TodoTaskModel taskModel =
                      controller.convertTodoList(snapshot.data!.docs[index]);
                  return Dismissible(
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      taskModel.idUser = widget.taskData["idUser"];
                      taskModel.taskName = widget.taskData["name"];
                      controller.deleteTask(taskModel);
                    },
                    background: Container(
                      color: const Color(0xffCC0000),
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(Icons.delete_outline_outlined,
                            color: Colors.white),
                      ),
                    ),
                    key: ValueKey(snapshot.data!.docs.length),
                    child: ListTile(
                      title: Text(
                        taskModel.task,
                        style:
                            const TextStyle(color: lightPurple, fontSize: 18),
                      ),
                      trailing: Checkbox(
                        value: taskModel.check,
                        fillColor: MaterialStateProperty.resolveWith<Color>((
                          Set<MaterialState> states,
                        ) {
                          if (states.contains(MaterialState.disabled)) {
                            return purple;
                          }
                          return mediumPurple;
                        }),
                        onChanged: (bool? value) {
                          taskModel.check = value!;
                          taskModel.idUser = widget.taskData["idUser"];
                          taskModel.taskName = widget.taskData["name"];
                          controller.updateTodoList(taskModel);
                        },
                      ),
                      onTap: () {
                        taskModel.taskName = widget.taskData["name"];
                        controller.manipulateText(taskModel.task);
                        showDialog(
                          context: context,
                          builder: (_) => AddTaskList(
                            taskModel: taskModel,
                            action: "Editar",
                            controller: controller,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        });
  }

  Padding _buildChangeOrder() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Observer(
        builder: (_) => IconButton(
          onPressed: () => setState(
            () => controller.changeOrder(widget.taskData),
          ),
          iconSize: 28,
          color: lightPurple,
          splashColor: lightPurple,
          highlightColor: lightPurple,
          icon: Icon(
            controller.descending
                ? Icons.arrow_circle_up_rounded
                : Icons.arrow_circle_down_rounded,
          ),
        ),
      ),
    );
  }
}
