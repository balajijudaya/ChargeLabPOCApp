import 'package:ChargeLabPoCApp/login_page.dart';
import 'package:ChargeLabPoCApp/signup_page.dart';
import 'package:ChargeLabPoCApp/components/auth_service.dart';
import 'package:ChargeLabPoCApp/verification_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChargeLabPoCApp());
}


class ChargeLabPoCApp extends StatefulWidget {
  @override
  _ChargeLabPoCAppState createState() => _ChargeLabPoCAppState();
}

class _ChargeLabPoCAppState extends State<ChargeLabPoCApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charge Lab PoC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // Show login page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(child: 
                    LoginPage(
                      shouldShowSignUp: _authService.showSignUp,
                      didProvideCredentials: _authService.loginWithCredentials,
                    ),
                  ),
                
                // Show verification code page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: 
                    VerificationPage(didProvideVerificationCode: _authService.verifyCode)
                  ),

                // show sign up page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(child: 
                    SignUpPage(
                      shouldShowLogin: _authService.showLogin,
                      didProvideCredentials: _authService.signUpWithCredentials,
                      )
                    ),

              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            // Snapshot has no data, show loading indicator
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}