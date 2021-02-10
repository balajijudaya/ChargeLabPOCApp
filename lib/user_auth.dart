import 'dart:async';

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

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }
}