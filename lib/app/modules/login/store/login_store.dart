import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist/app/model/user.dart';
import 'package:todolist/app/modules/login/repository/login_repository.dart';
import 'package:todolist/app/widgets/alert.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  String email = '';

  @action
  void setEmail(String text) => email = text;

  @observable
  String password = '';

  @action
  void setPassword(String text) => password = text;

  @computed
  bool get finish => email.isNotEmpty && password.isNotEmpty;

  @observable
  bool loading = true;

  @observable
  dynamic result = true;

  @action
  Future signInWithEmailAndPassword(context) async {
    if (finish) {
      loading = true;
      final user = UserModel();

      user.email = email.trim();
      user.password = password.trim();

      result = await LoginRepository().loginUser(user);
      loading = false;

      if (result != true) {
        alertDialog(context, AlertType.info, "ATENÇÃO", result);
      } else {
        Modular.to.navigate('/home');
      }
    } else {
      alertDialog(context, AlertType.info, "ATENÇÃO",
          "Preencha todos os campos para prosseguirmos!");
    }
  }
}
