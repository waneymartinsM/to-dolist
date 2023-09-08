import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/auth/store/auth_store.dart';
import 'package:todolist/app/utils/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final controller = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    controller.verifyLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: purple,
      body: Center(child: CircularProgressIndicator(color: lightPurple)),
    );
  }
}
