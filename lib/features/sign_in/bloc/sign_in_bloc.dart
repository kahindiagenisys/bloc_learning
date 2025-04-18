import 'package:bloc/bloc.dart';
import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/injection.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final _signInRepo = injection<SignInRepository>();

  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonPressed>(
      (event, emit) async {
        emit(SignInLoading());

        try {
          final res = await _signInRepo.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );



          await Future.delayed(const Duration(seconds: 5)); // simulate loading
        } catch (error) {
          emit(SignInFailure(error: error.toString()));
        } finally {
          emit(SignInInitial());
        }
      },
    );
  }
}
