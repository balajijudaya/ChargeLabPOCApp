import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';
import 'components/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        child: Column(
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
            Padding(padding: EdgeInsets.only(bottom: 90)),
          
            // Sign up form
            _signUpForm(),
            // Log in button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Text("Already have an account? Login."),
                onPressed: widget.shouldShowLogin,
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _signUpForm() {
    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Username text field
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Username",
            ),
            validator: (String value) {
              // Valid chars, username must be alphanumeric
              final validChars = RegExp(r"^[a-zA-Z0-9]+$");
              if (value.isEmpty || !validChars.hasMatch(value)) {
                return "Invalid username. Must be alphanumeric";
              } else {
                return null;
              }
            },
          ),

          // Email text field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.mail),
              labelText: "Email",
            ),
            validator: (String value) {
              // TODO: Needs Fixing
              final validEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
              if (value.isEmpty || !validEmail.hasMatch(value)) {
                return "Invalid email format";
              } else {
                return null;
              }
            },
          ),

          // Password text field
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open),
              labelText: "Password (8-16 chars)",
            ),
            validator: (String value) {
              // Must conain min eight chars, min one letter, and one number
              final validPass = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
              // TODO: Test
              if (value.isEmpty || !validPass.hasMatch(value)) {
                return "Must contain min 8 chars and a number";
              } else {
                return null;
              }
            },
          ),

          // Sign up button
          FlatButton(
            onPressed: _signUp,
            child: Text("Sign up"),
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }


  void _signUp() {
    if (widget._formKey.currentState.validate()) {
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

  

}