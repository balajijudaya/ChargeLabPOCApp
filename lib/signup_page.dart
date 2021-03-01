import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';
import 'components/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for Text for fields
  final ValueChanged<SignUpCredentials> didProvideCredentials;  // Callback signature for when user fills form
  final VoidCallback shouldShowLogin; // Callback to route to login page
  final PartnerBrand partnerBrand;    // PartnerBrand Obj containing whitelabel assets

  SignUpPage({
    Key key,
    this.didProvideCredentials,
    this.shouldShowLogin,
    @required this.partnerBrand,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Instantiate TextEditingControllers for respective text form fields
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
            // Brand Logo
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Center(
                child: widget.partnerBrand.logo,
              ),
            ),
            // Brand Greet Msg
            Text(
              widget.partnerBrand.greetMsg != null ? widget.partnerBrand.greetMsg : "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // Brand Support phone number
            Text(
              widget.partnerBrand.supportPhone != null ? widget.partnerBrand.supportPhone : "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 60)),
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

  // Returns a Form Widget for signing up a new user
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


  // Trim field entries, create credentials, and pass to callback
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