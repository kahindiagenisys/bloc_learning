import 'package:health_booster/core/error/exceptions/error_exception.dart'
    show ErrorException;
import 'package:health_booster/data/repositories/sign_up/sign_up_repository_interface.dart'
    show SignUpRepositoryInterface;
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpRepository implements SignUpRepositoryInterface {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth
          .signUp(email: email, password: password, data: {
        'full_name': fullName,
      });

      if (response.user == null) {
        throw ErrorException("Failed to create user");
      }
    } on AuthException catch (e) {
      throw ErrorException(e.message);
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }
}
