import 'package:ChargeLabPoCApp/components/auth_credentials.dart';
import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LogInCredentials> didProvideCredentials;
  // Triggered to show signup page for new users
  final VoidCallback shouldShowSignUp;

  LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp}) : super(key: key);

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
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(child: BrandLogo(
                  height: 64,
                  width: 64,
                )),
              ),
              BrandMessage(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 25)),
            ],
          ),
          _loginForm(),
          // Sign up button
          Container(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text("Don't have an account? Sign up!"),
              onPressed: widget.shouldShowSignUp,
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

    // Create and pass the credentials
    final credentials = LogInCredentials(
      username: username,
      password: password
    );
    widget.didProvideCredentials(credentials);
  }
}

