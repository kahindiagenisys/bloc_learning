part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpButtonPressed({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

class SignInSelectionEvent extends SignUpEvent {}
