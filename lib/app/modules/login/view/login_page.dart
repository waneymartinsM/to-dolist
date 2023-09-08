import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeTex(),
              const SizedBox(height: 20),
              _buildDescriptionText(),
              Image.asset('assets/todolist.png',
                  height: MediaQuery.of(context).size.height * 0.55),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _buildButtonSignIn(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _buildRowText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/login/register');
          },
          child: Text("Não tem uma conta? ",
              style: GoogleFonts.montserrat(color: lightPurple)),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/login/register');
          },
          child: Text("Registre-se",
              style: GoogleFonts.montserrat(
                  color: lightPurple, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          onPressed: () {
            Modular.to.pushNamed('/login/signIn');
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            backgroundColor: darkPurple,
          ),
          child:
              Text('LOGIN', style: GoogleFonts.montserrat(color: lightPurple)),
        ),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      "Finalmente alcance o foco, a organização e a calma com o To Do List",
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(color: lightPurple, fontSize: 15),
    );
  }

  Widget _buildWelcomeTex() {
    return Text(
      "Seja bem-vindo!",
      style: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold, fontSize: 30, color: lightPurple),
    );
  }
}
