import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/login/store/register_store.dart';
import 'package:todolist/app/modules/login/view/register_page.dart';
import 'package:todolist/app/modules/login/view/signIn_page.dart';
import '../store/login_store.dart';
import '../view/login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => RegisterStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ChildRoute('/register', child: (_, args) => const RegisterPage()),
    ChildRoute('/signIn', child: (_, args) => const SignInPage()),
  ];
}