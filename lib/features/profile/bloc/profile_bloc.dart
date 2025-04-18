import 'package:bloc/bloc.dart';
import 'package:health_booster/data/models/user/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<SetProfileEvent>(
      (event, emit) {
        emit(ProfileLoaded(user: event.user));
      },
    );
  }
}
