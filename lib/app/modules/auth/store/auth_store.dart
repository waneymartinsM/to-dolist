import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../repository/auth_repository.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authSevice = AuthRepository();

  verifyLoggedUser() {
    final loggedUser = _authSevice.checkCurrentUser();
    if (loggedUser) {
      Modular.to.navigate('/home');
    } else {
      Modular.to.navigate('/login');
    }
  }
}
