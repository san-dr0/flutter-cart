import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';

abstract class AuthState {}

class AuthOnLoadingState extends AuthState {}
class AuthOnValidCredentialsState extends AuthState {
  AuthCredentialsModel? authCredentialsModel;

  AuthOnValidCredentialsState({required this.authCredentialsModel});
}

class AuthOnInvalidCredentialsState extends AuthState {
  String errorMessage;
  AuthOnInvalidCredentialsState({required this.errorMessage});
}

class AuthOnIssueInSigningUpState extends AuthState {
  String message;

  AuthOnIssueInSigningUpState({required this.message});
}

class AuthNotLoggedInState extends AuthState {}

class AuthErrorSavingCartTransctionState extends AuthState {}

class AuthOnResetCartProductListState extends AuthState {}

class AuthCheckCurrentActiveUserCurrentBalanceState extends AuthState {}
