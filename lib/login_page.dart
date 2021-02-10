import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(children: [
          loginForm(),
          // Sign up button
          Container(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text("Don't have an account? Sign up!"),
              onPressed: () {

              },
            ),
          )
        ],),
      ),
    );
  }



  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username field
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: "Username",
          ),
        ),
        // Password field
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: "Password",
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        // Login Button
        FlatButton(
          onPressed: login,
          child: Text("Login"),
          color: Theme.of(context).accentColor,
        ),
      ]
    );
  }


  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    print("username: $username\npassword: $password\n");
  }
}

