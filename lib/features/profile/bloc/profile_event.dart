part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class SetProfileEvent extends ProfileEvent {
  final User? user;

  const SetProfileEvent(this.user);
}

class ClearProfileEvent extends ProfileEvent {}
