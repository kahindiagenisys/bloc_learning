import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_booster/core/extensions/string_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String role,
    required String fullName,
    String? accessToken,
    String? refreshToken,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromSupabase(AuthResponse response) {
    final rawUser = response.user!;

    return User(
      id: rawUser.id,
      fullName: rawUser.userMetadata?['full_name'],
      email: rawUser.email.orEmpty,
      role: rawUser.role ?? 'authenticated',
      accessToken: response.session?.accessToken,
      refreshToken: response.session?.refreshToken,
      createdAt: rawUser.createdAt.toDateTime!,
      updatedAt: rawUser.updatedAt.toDateTime,
    );
  }
}
