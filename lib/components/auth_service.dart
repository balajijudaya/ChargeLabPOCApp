import 'dart:async';

import 'package:ChargeLabPoCApp/components/auth_credentials.dart';

enum AuthFlowStatus {
  login,
  signUp,
  verification,
  session
}

// Object to be observed by the stream in the StreamBuilder
class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

// Manages the stream controller of AuthState and contains all the authentication functionality
class AuthService {
  final authStateController = StreamController<AuthState>();

  // Set AuthState to show the signup page
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  // Set AuthState to show the log in page
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  void loginWithCredentials(AuthCredentials credentials) {
    final state = AuthState(authFlowStatus: AuthFlowStatus.session);
    authStateController.add(state);
  }

  void signUpWithCredentials(SignUpCredentials credentials) {
    final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
    authStateController.add(state);
  }

  void verifyCode(String verificationCode) {
    final state = AuthState(authFlowStatus: AuthFlowStatus.session);
    authStateController.add(state);
  }
  
  // Log out by setting Authstate back to login
  void logOut() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}