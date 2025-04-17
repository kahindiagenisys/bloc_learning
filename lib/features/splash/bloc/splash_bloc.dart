import 'package:bloc/bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashInitialEvent>((event, emit) async {
      final duration = event.appNameLength * event.animationSpeed;

      await Future.delayed(Duration(milliseconds: duration));

      final isLoggedIn = await checkAuthStatus();

      if (isLoggedIn) {
        emit(SplashNavigateToHomeState());
      } else {
        emit(SplashNavigateToLoginState());
      }
    });
  }

  Future<bool> checkAuthStatus() async {
    return false;
  }
}
