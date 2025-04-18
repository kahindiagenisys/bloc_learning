abstract class SignUpRepositoryInterface {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String fullName,
    required String password,
  });
}
