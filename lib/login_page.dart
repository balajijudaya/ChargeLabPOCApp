import 'package:ChargeLabPoCApp/components/auth_credentials.dart';
import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();   // Key for text form field
  final ValueChanged<LogInCredentials> didProvideCredentials;     // Callback signature for when user fills form
  final VoidCallback shouldShowSignUp;  // Callback to route users to sign up page for account creation
  final PartnerBrand partnerBrand;      // PartnerBrand Obj containing whitelabel assets

  LoginPage({
    Key key, 
    this.didProvideCredentials, 
    this.shouldShowSignUp, 
    @required this.partnerBrand,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Instantiate TextEditingControllers for respective text form fields
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: widget.partnerBrand.logo
            ),
          ),
          Text(
            widget.partnerBrand.greetMsg != null ? widget.partnerBrand.greetMsg : "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.partnerBrand.supportPhone != null ? widget.partnerBrand.supportPhone : "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 60)),
        
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
    return Form(
      key: widget._formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Username field
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
          // Password field
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open),
              labelText: "Password",
            ),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              // Must conain min eight chars, min one letter, and one number
              final validPass = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
              
              if (value.isEmpty || !validPass.hasMatch(value)) {
                return "Must contain min 8 chars and a number";
              } else {
                return null;
              }
            },
          ),
          // Login Button
          FlatButton(
            onPressed: _login,
            child: Text("Login"),
            color: Theme.of(context).accentColor,
          ),
        ]
      ),
    );
  }


  void _login() {
    if (widget._formKey.currentState.validate()) {
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
  
}

