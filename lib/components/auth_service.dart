import 'dart:async';
import 'package:ChargeLabPoCApp/components/auth_credentials.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

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
  
  //Keeps SignUpCredentials in memory so user can immediately log in after verification
  AuthCredentials _credentials;

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

  // Log in user with verified credentials through AWS Amplify
  void loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: credentials.username,
        password: credentials.password
      );

      // User is signed in, update state to session
      if (result.isSignedIn) {
        final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
      } else {
        print("User could not be signed in");
      }
    } on AuthException catch (authError) {
      print("Could not login user - ${authError.message}");
    }

  }

  // Sign up user with credentials through AWS Amplify
  void signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {"email": credentials.email};

      final result = await Amplify.Auth.signUp(
        username: credentials.username,
        password: credentials.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes)
      );

      // Set credentials and verify user email
      this._credentials = credentials;
      final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
      authStateController.add(state);
      
      // Log in user on successful sign up
      if (result.isSignUpComplete) {
        loginWithCredentials(credentials);
      }
    
    } on AuthException catch (authError) {
      print("Failed to sign up - ${authError.message}");
    }
  }

  // Verify user email address on sign up
  void verifyCode(String verificationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: _credentials.username,
        confirmationCode: verificationCode
      );

      // Log in user on successful sign up
      if (result.isSignUpComplete) {
        loginWithCredentials(_credentials);
      } else {

      }
    } on AuthException catch (authError) {
      print("Could not verify code - ${authError.message}");
    }
  }
  
  // Sign out user & return to log in page
  void logOut() async {
    try {
      await Amplify.Auth.signOut(); // Sign out on this device, not all platforms

      showLogin();
    } on AuthException catch (authError) {
      print("Could not log out - ${authError.message}");
    }
  }

  // Log in user if app is close but they've already logged in during a previous session
  void checkAuthStatus() async {
    // Attempt to fetch current session
    try {
      await Amplify.Auth.fetchAuthSession();

      final state = AuthState(authFlowStatus: AuthFlowStatus.session);
      authStateController.add(state);
    } catch (_) { // Unable to fetch, show login page
      final state = AuthState(authFlowStatus: AuthFlowStatus.login);
      authStateController.add(state);
    }
  }


}