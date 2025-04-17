import 'package:bloc/bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashStatusState> {
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
    return false;
  }
}
