part of 'sign_in_bloc.dart';

abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {}

class SignUpSelection extends SignInState {}

class ForgotPasswordSelection extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});
}
