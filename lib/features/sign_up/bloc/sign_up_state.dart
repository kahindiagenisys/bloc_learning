part of 'sign_up_bloc.dart';

abstract class SignUpState {
  const SignUpState();
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});
}

class SignInSelection extends SignUpState {}
