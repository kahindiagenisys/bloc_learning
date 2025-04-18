import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_booster/core/error/exceptions/error_exception.dart';
import 'package:health_booster/data/repositories/sign_up/sign_up_repository.dart';
import 'package:health_booster/injection.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final _signUpRepo = injection<SignUpRepository>();

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>(
      (event, emit) async {
        emit(SignUpLoading());

        try {
          await _signUpRepo.signUpWithEmailAndPassword(
            email: event.email,
            fullName: event.fullName,
            password: event.password,
          );

          emit(SignUpSuccess());

        } on ErrorException catch (e) {
          emit(SignUpFailure(error: e.message));
        } finally {
          emit(SignUpInitial());
        }
      },
    );

    on<SignInSelectionEvent>(
      (event, emit) {
        emit(SignInSelection());
      },
    );
  }
}
