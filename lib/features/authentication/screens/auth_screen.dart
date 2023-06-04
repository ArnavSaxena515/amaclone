// Class for the authentication screen
import 'package:amaclone/auth_service.dart';
import 'package:amaclone/common/widgets/custom_button.dart';
import 'package:amaclone/common/widgets/custom_textfield.dart';
import 'package:amaclone/constants/global_variables.dart';
import 'package:flutter/material.dart';

// enum to handle auth value
enum Auth {
  login,
  signup,
}

class AuthScreen extends StatefulWidget {
  // route name for this widget
  static const String routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final containerHeight = 3.0;

  // declaring form keys
  final _signUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  // defining the input controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  final AuthService _authService = AuthService();

  // handling disposals
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
  }

  void signUpUser() {
    _authService.signUpUser(
        email: _email.text,
        password: _password.text,
        context: context,
        name: _name.text);
  }

  void loginUser() {
    _authService.loginUser(
        email: _email.text, password: _password.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          //todo create an animation for switching between create account and signup
          ListTile(
            tileColor: _auth == Auth.signup
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundColor,
            title: const Text("Create Account"),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.signup,
              groupValue: _auth,
              onChanged: (Auth? val) {
                setState(() {
                  _auth = val!;

                });
              },
            ),
          ),
          if (_auth == Auth.signup)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _name,
                      hintText: "Name",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _email,
                      hintText: "Email",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _password,
                      hintText: "Password",
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: "Sign Up",
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        })
                  ],
                ),
              ),
            ),
          ListTile(
            tileColor: _auth == Auth.login
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundColor,
            title: const Text("Login"),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.login,
              groupValue: _auth,
              onChanged: (Auth? val) {
                setState(() {
                  _auth = val!;
                });
              },
            ),
          ),
          if (_auth == Auth.login)
            Container(
              padding: const EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _email,
                      hintText: "Email",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _password,
                      hintText: "Password",
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: "Log In",
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            loginUser();
                          }
                        })
                  ],
                ),
              ),
            ),
        ],
      )),
    );
  }
}
