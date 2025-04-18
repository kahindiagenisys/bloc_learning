import 'package:auto_route/auto_route.dart';
import 'package:health_booster/features/home/views/home_screen.dart';
import 'package:health_booster/features/sign_in/views/sign_in_screen.dart';
import 'package:health_booster/features/sign_up/views/sign_up_screen.dart' show SignUpScreen;
import 'package:health_booster/features/splash/views/splash_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        )
      ];
}
