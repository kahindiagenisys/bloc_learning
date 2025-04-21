import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';
import 'package:health_booster/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/features/splash/bloc/splash_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<SignInRepository>(),
  MockSpec<SignInBloc>(),
  MockSpec<ProfileBloc>(),
  MockSpec<SplashBloc>(),
])
void main() {
  // This is a placeholder for the test setup.
  // You can add your test setup code here.
}