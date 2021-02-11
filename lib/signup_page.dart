import 'package:flutter/material.dart';
import 'components/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  // Triggered to show login page from sign up
  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            // Sign up form
            _signUpForm(),
            // Log in button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Text("Already have an account? Login."),
                onPressed: widget.shouldShowLogin,
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username text field
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: "Username",
          ),
        ),

        // Email text field
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            labelText: "Email",
          ),
        ),

        // Password text field
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_open),
            labelText: "Password (8-16 chars)",
          ),
        ),

        // Sign up button
        FlatButton(
          onPressed: _signUp,
          child: Text("Sign up"),
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }


  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print("username: $username\nemail: $email\npassword: $password\n");

    // Create and pass the credentials
    final credentials = SignUpCredentials(
      username: username,
      email: email,
      password: password,
    );
    widget.didProvideCredentials(credentials);

  }
}