import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';

// Slim version of log in page that passes a verification code up the widget tree
class VerificationPage extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;  
  final PartnerBrand partnerBrand;    // PartnerBrand Obj containing whitelabel assets

  VerificationPage({Key key, this.didProvideVerificationCode, @required this.partnerBrand}) :
    super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // Instantiate TextEditingControllers for verification text form fields
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            // Brand Logo
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 120),
              child: Center(
                child: widget.partnerBrand.logo
              ),
            ),
            Text(
              "A verification code has been sent to your email."
            ),
            Padding(padding: EdgeInsets.only(top: 10),),
            _verificationForm(),
          ],
        ),
      ),
    );
  }

  // Returns a widget with a textfield and button for the user to enter a code to verify
  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Verification code text field
        TextField(
          controller: _verificationCodeController,
          decoration: InputDecoration(
            icon: Icon(Icons.confirmation_number),
            labelText: "Verification Code",
          ),
        ),
        // Verify Button
        FlatButton(
          onPressed: _verify,
          child: Text("Verify"),
          color: Theme.of(context).accentColor,
        ),
        Padding(padding: EdgeInsets.only(bottom: 0),),
      ]
    );
  }

  // Trim form entry and pass to verification callback
  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode(verificationCode);
  }
}