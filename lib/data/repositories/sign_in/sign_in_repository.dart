import 'package:health_booster/core/error/exceptions/error_exception.dart'
    show ErrorException;
import 'package:health_booster/core/services/secure_storage/secure_storage.dart';
import 'package:health_booster/data/models/user/user.dart' as user_model;
import 'package:health_booster/data/repositories/sign_in/sign_in_repository_interface.dart';
import 'package:health_booster/injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInRepository implements SignInRepositoryInterface {
  final _supabaseClient = Supabase.instance.client;
  final _storage = injection<SecureStorageService>();

  @override
  Future<user_model.User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final session = response.session;
      final user = response.user;

      if (session == null || user == null) {
        throw ErrorException('Session or user not found');
      }

      final authUser = user_model.User.fromSupabase(response);

      // Store the authenticated user in secure storage
      final currentUser = await _storage.setAuthenticatedUser(authUser);

      return currentUser;
    } on AuthException catch (e) {
      throw ErrorException(e.message);
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabaseClient.auth.signOut();
      await _storage.clearAllLocalData();
    } on AuthException catch (e) {
      throw ErrorException(e.message);
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }
}
