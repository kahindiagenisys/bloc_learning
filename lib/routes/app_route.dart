import 'package:auto_route/auto_route.dart';
import 'package:health_booster/features/home/views/home_screen.dart';
import 'package:health_booster/features/sing_in/views/sign_in_screen.dart';
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
          page: SingInRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
      ];
}
