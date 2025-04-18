import 'package:bloc/bloc.dart';
import 'package:health_booster/core/error/exceptions/error_exception.dart' show ErrorException;
import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';
import 'package:health_booster/injection.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final _signInRepo = injection<SignInRepository>();

  final _profile = injection<ProfileBloc>();

  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonPressed>(
      (event, emit) async {
        emit(SignInLoading());

        try {
          final res = await _signInRepo.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          if (res == null) {
            emit(SignInFailure(error: "Invalid credentials"));
            return;
          }

          _profile.add(SetProfileEvent(res));

          emit(SignInSuccess());
        } on ErrorException catch (error) {
          emit(SignInFailure(error: error.message));
        } finally {
          emit(SignInInitial());
        }
      },
    );

    on<SignUpSelectionEvent>(
      (event, emit) {
        emit(SignUpSelection());
      },
    );
  }

  Future<void> logout() async {
    await _signInRepo.logout();
    _profile.add(SetProfileEvent(null));
  }
}
