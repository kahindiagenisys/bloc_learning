part of 'splash_bloc.dart';

abstract class SplashEvent {}

class SplashInitialEvent extends SplashEvent {
  final int appNameLength;
  final int animationSpeed;
  SplashInitialEvent({
    required this.appNameLength,
    required this.animationSpeed,
  });
}
