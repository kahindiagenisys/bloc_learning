import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_booster/core/extensions/string_extensions.dart';
import 'package:health_booster/data/models/user/user.dart';

/// user data save of using this key (id,email,token)
const lastAuthenticatedUserKey = "lastAuthenticatedUser";

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  /// Deletes all stored data from secure storage
  Future<void> clearAllLocalData() async {
    await _storage.deleteAll();
  }

  /// Stores authenticated user information securely
  /// [user] - The user information (AuthInfo) to be stored
  /// If the user is `null`, the function does nothing
  Future<User?> setAuthenticatedUser(User? user) async {
    if (user == null) return user;
    await _storage.write(
      key: lastAuthenticatedUserKey,
      value: jsonEncode(user),
    );
    return user;
  }

  /// Retrieves the last authenticated user information
  /// Returns `null` if no data is found
  Future<User?> getLastAuthenticatedUser() async {
    String? userDetail = await _storage.read(
      key: lastAuthenticatedUserKey,
    );
    if (userDetail.isEmptyOrNullValue) {
      return null;
    }
    final auth = User.fromJson(json.decode(userDetail!));
    return auth;
  }
}
