import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/model/todo.dart';
import 'package:todolist/app/modules/home/store/home_store.dart';
import 'package:todolist/app/utils/colors.dart';

class AddTaskList extends StatelessWidget {
  AddTaskList({
    Key? key,
    required this.action,
    this.hintText = 'Tarefa',
    this.buttomText = 'Salvar',
    required this.controller,
    this.taskModel,
  }) : super(key: key);

  final String action;
  final String hintText;
  final String buttomText;
  final HomeStore controller;
  final TodoTaskModel? taskModel;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: lightPurple,
        title: Text(action, style: GoogleFonts.montserrat()),
        content: TextFormField(
          maxLength: 65,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Insira uma tarefa!';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: purple),
            ),
          ),
          cursorColor: purple,
          controller: controller.textController,
        ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (action == "Adicionar") {
                    controller.addTask(taskModel!);
                  } else if (action == "Lista") {
                    await controller.addList();
                  } else if (action == "Editar") {
                    controller.editTask(taskModel!);
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(purple),
              ),
              child: Text(
                buttomText,
                style: GoogleFonts.montserrat(color: lightPurple, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
