import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_booster/data/models/user/user.dart';
import 'package:health_booster/data/repositories/sign_in/sign_in_repository.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';
import 'package:health_booster/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/features/splash/bloc/splash_bloc.dart';
import 'package:health_booster/injection.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.mocks.dart';

void main() {
  late MockProfileBloc mockProfileBloc;
  late MockSignInRepository mockSignInRepository;
  late MockSignInBloc mockSignInBloc;

  setUp(() {
    mockProfileBloc = MockProfileBloc();
    mockSignInRepository = MockSignInRepository();
    mockSignInBloc = MockSignInBloc();

    injection.registerSingleton<ProfileBloc>(mockProfileBloc);
    injection.registerSingleton<SignInRepository>(mockSignInRepository);
    injection.registerSingleton<SignInBloc>(mockSignInBloc);
  });

  tearDown(() {
    injection.unregister<ProfileBloc>();
    injection.unregister<SignInRepository>();
    injection.unregister<SignInBloc>();
  });

  group("test auth token", () {
    blocTest<SplashBloc, SplashStatusState>(
      'emits [navigateToLogin] when no user is found',
      build: () {
        when(mockSignInRepository.getLastAuthenticatedUser())
            .thenAnswer((_) async => null);
        return SplashBloc();
      },
      act: (bloc) async {
        bloc.add(SplashInitialEvent(appNameLength: 5, animationSpeed: 200));
        await Future.delayed(Duration(milliseconds: 1000));
      },
      expect: () => [
        SplashStatusState.navigateToLogin,
      ],
    );

    final user = User(
      id: "e92345d0-b03d-48ba-b0c7-149643b15b34",
      email: "kah@indiagenisys.com",
      role: "authenticated",
      fullName: "Kartik",
      accessToken:
          "eyJhbGciOiJIUzI1NiIsImtpZCI6IkcrdkMyRWpmbTQyZW1KTVUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL21wbGh2bnB4cml0ZWNueXhqbmZ6LnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiJlOTIzNDVkMC1iMDNkLTQ4YmEtYjBjNy0xNDk2NDNiMTViMzQiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzQ1MjIyNDU2LCJpYXQiOjE3NDUyMTg4NTYsImVtYWlsIjoia2FoQGluZGlhZ2VuaXN5cy5jb20iLCJwaG9uZSI6IiIsImFwcF9tZXRhZGF0YSI6eyJwcm92aWRlciI6ImVtYWlsIiwicHJvdmlkZXJzIjpbImVtYWlsIl19LCJ1c2VyX21ldGFkYXRhIjp7ImVtYWlsIjoia2FoQGluZGlhZ2VuaXN5cy5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZnVsbF9uYW1lIjoiS2FydGlrIiwicGhvbmVfdmVyaWZpZWQiOmZhbHNlLCJzdWIiOiJlOTIzNDVkMC1iMDNkLTQ4YmEtYjBjNy0xNDk2NDNiMTViMzQifSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJwYXNzd29yZCIsInRpbWVzdGFtcCI6MTc0NTIxODg1Nn1dLCJzZXNzaW9uX2lkIjoiMTg1ODE4YzYtMjBkMy00MjRiLWI3YWUtOGNjZWU4OTA3ZGRhIiwiaXNfYW5vbnltb3VzIjpmYWxzZX0.8rtsyT-qKhCY3b3gk8yA89j8dxmiKYe9QkbYaNiUezs",
      refreshToken: "pBz6BlzTOzIBih8uGwBppg",
      createdAt: DateTime(2025 - 04 - 18),
    );

    blocTest<SplashBloc, SplashStatusState>(
      'emits [navigateToHome] when user is found',
      build: () {
        when(mockSignInRepository.getLastAuthenticatedUser())
            .thenAnswer((_) async => user);

        when(mockProfileBloc.isCurrentUserTokenExpired).thenReturn(true);
        return SplashBloc();
      },
      act: (bloc) async {
        bloc.add(SplashInitialEvent(appNameLength: 5, animationSpeed: 200));
        await Future.delayed(Duration(milliseconds: 2000));
      },
      expect: () => [
        SplashStatusState.navigateToHome,
      ],
    );
  });
}
