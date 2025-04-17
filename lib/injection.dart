import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:health_booster/features/sing_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/features/splash/bloc/splash_bloc.dart';

final injection = GetIt.instance;

Future<void> initialized() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

void setupInjection() {
  injection.registerLazySingleton<SplashBloc>(() => SplashBloc());
  injection.registerLazySingleton<SignInBloc>(() => SignInBloc());
}
