part of 'splash_bloc.dart';


enum SplashStatus {
  initial,
  navigateToHome,
  navigateToLogin,
}

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashNavigateToHomeState extends SplashState {}

class SplashNavigateToLoginState extends SplashState {}
