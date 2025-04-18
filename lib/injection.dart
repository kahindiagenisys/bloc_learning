import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/services/secure_storage/secure_storage.dart';
import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';
import 'package:health_booster/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/features/splash/bloc/splash_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final injection = GetIt.instance;

Future<void> initialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _supabaseInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

Future<void> _supabaseInitialized() async {
  await Supabase.initialize(
    url: appSupabaseUrl,
    anonKey: appSupabaseAnonKey,
  );
}

Future<void> setupInjection() async {
  injection.registerSingleton<SecureStorageService>(SecureStorageService());
  injection.registerSingleton<SignInRepository>(SignInRepository());

  injection.registerLazySingleton<SplashBloc>(() => SplashBloc());
  injection.registerLazySingleton<SignInBloc>(() => SignInBloc());
  injection.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
}
