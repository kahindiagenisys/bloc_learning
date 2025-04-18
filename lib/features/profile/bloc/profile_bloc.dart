import 'package:bloc/bloc.dart';
import 'package:health_booster/data/models/user/user.dart';
import 'package:nb_utils/nb_utils.dart' show JwtDecoder;

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

  bool get isCurrentUserTokenExpired {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;

      if (user?.accessToken != null) {
        return JwtDecoder.isExpired(user!.accessToken!);
      }
    }
    return true;
  }
}
