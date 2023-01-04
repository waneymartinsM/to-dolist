import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist/app/model/user.dart';
import 'package:todolist/app/modules/login/store/register_store.dart';
import 'package:todolist/app/widgets/alert.dart';
import 'package:todolist/app/utils/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterStore controller = Modular.get();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool passwordHide = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: purple,
        body: loading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: purple,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/app_bar.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Crie uma conta \nagora mesmo",
                            style: TextStyle(
                              fontSize: 30,
                              color: lightPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: mediumPurple,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nome",
                                      hintStyle: TextStyle(
                                        color: mediumPurple,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: mediumPurple,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: lightPurple,
                                    ),
                                    cursorColor: mediumPurple,
                                    controller: nameController,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: mediumPurple,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "E-mail",
                                      hintStyle: TextStyle(
                                        color: mediumPurple,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: mediumPurple,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: lightPurple,
                                    ),
                                    cursorColor: mediumPurple,
                                    controller: emailController,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: mediumPurple,
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    obscureText: passwordHide,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Senha",
                                      hintStyle: const TextStyle(
                                        color: mediumPurple,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_outlined,
                                        color: mediumPurple,
                                      ),
                                      suffixIcon: IconButton(
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          if (passwordHide == true) {
                                            setState(() {
                                              passwordHide = false;
                                            });
                                          } else {
                                            setState(() {
                                              passwordHide = true;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          passwordHide == true
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off,
                                          color: mediumPurple,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: lightPurple,
                                    ),
                                    cursorColor: mediumPurple,
                                    controller: passwordController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: darkPurple,
                            ),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: TextButton(
                                  onPressed: () async {
                                    final user = UserModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    List result =
                                        controller.validateFields(user);

                                    if (result.first == true) {
                                      setState(() => loading = true);
                                      bool result =
                                          await controller.signUpUser(user);
                                      if (result) {
                                        Modular.to.navigate('/home');
                                        setState(() => loading = false);
                                      } else {
                                        alertDialog(
                                            context,
                                            AlertType.error,
                                            'Atenção',
                                            'Ocorreu um erro ao criar conta.\nTente novamente!');
                                      }
                                    } else {
                                      final info = result[0];
                                      final title = result[1];
                                      final description = result[2];
                                      alertDialog(
                                        context,
                                        info,
                                        title,
                                        description,
                                      );
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: lightPurple,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 60,
                                    ),
                                    backgroundColor: darkPurple,
                                  ),
                                  child: const Text(
                                    'REGISTRAR',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Modular.to.pushNamed('/login/signIn');
                                },
                                child: const Text(
                                  "Já tem uma conta? ",
                                  style: TextStyle(
                                    color: lightPurple,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Modular.to.pushNamed('/login/signIn');
                                },
                                child: const Text(
                                  "Entrar",
                                  style: TextStyle(
                                    color: lightPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
