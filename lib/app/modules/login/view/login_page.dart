import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: purple,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Seja bem-vindo!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: lightPurple,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Finalmente alcance o foco, a organização e a calma com o To Do List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: lightPurple,
                    fontSize: 15,
                  ),
                ),
                Image.asset(
                  'assets/todolist.png',
                  height: size.height * 0.55,
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: TextButton(
                      onPressed: () {
                        Modular.to.pushNamed('/login/signIn');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        backgroundColor: darkPurple,
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: lightPurple,
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
                        Modular.to.pushNamed('/login/register');
                      },
                      child: const Text(
                        "Não tem uma conta? ",
                        style: TextStyle(
                          color: lightPurple,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed('/login/register');
                      },
                      child: const Text(
                        "Registre-se",
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
          ),
        ),
      ),
    );
  }
}
