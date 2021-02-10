/*
Class containing the minimum info required for logging in/signing up so that it can
be used interchangeably
*/
abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({this.username, this.password});
}

// Implementation of AuthCredentials for logging in
class LogInCredentials extends AuthCredentials {
  LogInCredentials({String username, String password}) :
    super(username: username, password: password);
}

// Implementation of AuthCredentials for signing up
class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({String username, String password, this.email}) : 
    super(username: username, password: password);
}