import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/modules/login/store/login_store.dart';
import 'package:todolist/app/utils/colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LoginStore controller = Modular.get();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  bool passwordHide = true;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(backgroundColor: purple, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageAppBar(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextWelcome(),
                const SizedBox(height: 40),
                _buildForm(),
                const SizedBox(height: 40),
                _buildButtonSignIn(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _buildRowText(),
              ],
            ),
          )
        ],
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
            onPressed: () {
              controller.signInWithEmailAndPassword(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: lightPurple,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              backgroundColor: darkPurple,
            ),
            child: Text('ENTRAR', style: GoogleFonts.montserrat()),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
        ),
        child: Column(
          children: [_buildEmailFormField(), _buildPasswordFormField()],
        ),
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: mediumPurple))),
      child: TextFormField(
        obscureText: passwordHide,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Senha",
          hintStyle: GoogleFonts.montserrat(color: mediumPurple),
          prefixIcon: const Icon(Icons.lock_outlined, color: mediumPurple),
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
        style: GoogleFonts.montserrat(color: lightPurple),
        cursorColor: mediumPurple,
        onChanged: controller.setPassword,
        controller: passwordController,
      ),
    );
  }

  Widget _buildEmailFormField() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: mediumPurple)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "E-mail",
          hintStyle: GoogleFonts.montserrat(color: mediumPurple),
          prefixIcon: const Icon(Icons.email_outlined, color: mediumPurple),
        ),
        style: GoogleFonts.montserrat(color: lightPurple),
        cursorColor: mediumPurple,
        onChanged: controller.setEmail,
        controller: emailController,
      ),
    );
  }

  Widget _buildTextWelcome() {
    return Text(
      "Olá, bem-vindo \nde volta!",
      style: GoogleFonts.montserrat(
        fontSize: 28,
        color: lightPurple,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImageAppBar() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/app_bar.png"))),
            ),
          ),
        ],
      ),
    );
  }
}
