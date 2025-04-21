import 'package:health_booster/data/models/user/user.dart';

abstract class SignInRepositoryInterface {
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> getLastAuthenticatedUser();

  Future<void> logout();
}
