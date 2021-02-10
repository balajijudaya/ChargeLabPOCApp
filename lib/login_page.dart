import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(children: [
          _loginForm(),
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



  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username field
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: "Username",
          ),
        ),
        // Password field
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: "Password",
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        // Login Button
        FlatButton(
          onPressed: _login,
          child: Text("Login"),
          color: Theme.of(context).accentColor,
        ),
      ]
    );
  }


  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print("username: $username\npassword: $password\n");
  }
}

