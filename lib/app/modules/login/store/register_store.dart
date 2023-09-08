import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist/app/model/user.dart';
import 'package:todolist/app/modules/login/repository/login_repository.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  List validateFields(UserModel model) {
    if (model.name.isEmpty) {
      return [AlertType.info, "Atenção", "Insira o seu nome!"];
    } else if (model.email.isEmpty) {
      return [AlertType.info, "Atenção", "Insira o seu e-mail!"];
    } else if (EmailValidator.validate(model.email) == false) {
      return [AlertType.info, "Atenção", "E-mail é inválido!"];
    } else if (model.password.isEmpty) {
      return [AlertType.info, "Atenção", "Insira sua senha!"];
    } else if (model.password.length < 7) {
      return [AlertType.info, "Atenção", "Sua senha tem menos de 7 caracteres"];
    }
    return [true];
  }

  Future<bool> signUpUser(UserModel model) async {
    final repository = LoginRepository();
    final user = await repository.createAccount(model);
    if (user != null) {
      return await repository.registerUser(model, user);
    } else {
      return false;
    }
  }
}
