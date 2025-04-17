import 'package:bloc/bloc.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonPressed>(
      (event, emit) async {
        emit(SignInLoading());

        try {
          await Future.delayed(const Duration(seconds: 5)); // simulate loading
        } catch (e) {
        } finally {
          emit(SignInInitial());
        }
      },
    );
  }
}
