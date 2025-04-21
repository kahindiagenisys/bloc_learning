import 'package:bloc/bloc.dart';
import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';
import 'package:health_booster/injection.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashStatusState> {
  final _profile = injection<ProfileBloc>();
  final _signIn = injection<SignInRepository>();

  SplashBloc() : super(SplashStatusState.initial) {
    // Listen for SplashInitialEvent
    on<SplashInitialEvent>(
      (event, emit) async {
        final duration = event.appNameLength * event.animationSpeed;

        await Future.delayed(Duration(milliseconds: duration));

        final isLoggedIn = await checkAuthStatus();

        if (isLoggedIn) {
          emit(SplashStatusState.navigateToHome);
        } else {
          emit(SplashStatusState.navigateToLogin);
        }
      },
    );
  }

  Future<bool> checkAuthStatus() async {
    final lastAuthenticateUser = await _signIn.getLastAuthenticatedUser();
    if (lastAuthenticateUser != null) {
      _profile.add(SetProfileEvent(lastAuthenticateUser));

      return _profile.isCurrentUserTokenExpired;
    }

    return false;
  }
}
