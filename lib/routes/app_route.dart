import 'package:auto_route/auto_route.dart';
import 'package:health_booster/features/home/views/home_screen.dart';
import 'package:health_booster/features/sing_in/views/sing_in_screen.dart';
import 'package:health_booster/features/splash/view/splash_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        )
      ];
}
