import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/modules/auth/module/auth_module.dart';
import 'package:todolist/app/modules/login/module/login_module.dart';

import 'modules/home/module/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/login', module: LoginModule()),
  ];

}