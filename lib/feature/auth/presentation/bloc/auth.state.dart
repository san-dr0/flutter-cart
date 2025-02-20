import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';

abstract class AuthState {}

class AuthOnLoadingState extends AuthState {}
class AuthOnValidCredentials extends AuthState {
  AuthCredentialsModel? authCredentialsModel;

  AuthOnValidCredentials({required this.authCredentialsModel});
}
