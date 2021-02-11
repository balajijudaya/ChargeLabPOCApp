import 'package:ChargeLabPoCApp/amplifyconfiguration.dart';
import 'package:ChargeLabPoCApp/login_page.dart';
import 'package:ChargeLabPoCApp/page_flow.dart';
import 'package:ChargeLabPoCApp/signup_page.dart';
import 'package:ChargeLabPoCApp/components/auth_service.dart';
import 'package:ChargeLabPoCApp/verification_page.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChargeLabPoCApp());
}


class ChargeLabPoCApp extends StatefulWidget {
  @override
  _ChargeLabPoCAppState createState() => _ChargeLabPoCAppState();
}

class _ChargeLabPoCAppState extends State<ChargeLabPoCApp> {
  final _amplify = Amplify;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
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
                    )
                  ),
                

                // show sign up page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(child: 
                    SignUpPage(
                      shouldShowLogin: _authService.showLogin,
                      didProvideCredentials: _authService.signUpWithCredentials,
                      )
                    ),

                // Show verification code page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: 
                    VerificationPage(didProvideVerificationCode: _authService.verifyCode
                    )
                  ),

                // Show App Pages
                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(child: 
                    PageFlow(shouldLogOut: _authService.logOut
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

  // Configures amplify
  void _configureAmplify() async {
    _amplify.addPlugin(AmplifyAuthCognito());

    try {
      await _amplify.configure(amplifyconfig);
      print("Successfully configured Amplify");
    } catch (e) {
      print("Could not configure Amplify");
    }
  }
}