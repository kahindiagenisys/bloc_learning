import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:health_booster/features/splash/bloc/splash_bloc.dart';
import 'package:health_booster/injection.dart';
import 'package:health_booster/routes/app_route.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:typethis/typethis.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final animationSpeed = 200;
  final _splash = injection<SplashBloc>();

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    log("Build call in splash screen");
    _splash.add(
      SplashInitialEvent(appNameLength: myAppName.length, animationSpeed: 200),
    );

    return BlocListener<SplashBloc, SplashState>(
      listener: (BuildContext context, Object? state) {
        if (state is SplashNavigateToHomeState) {
          context.router.replaceAll([const HomeRoute()]);
        } else if (state is SplashNavigateToLoginState) {
          context.router.replaceAll([const SingInRoute()]);
        }
      },
      child: Scaffold(
        backgroundColor: color.primary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSplashIcon(context),
            20.height,
            buildSplashText(context),
          ],
        ),
      ),
    );
  }

  Widget buildSplashIcon(BuildContext context) {
    return Icon(
      LucideIcons.wallet,
      size: 100,
      color: context.colorScheme.onPrimary,
    );
  }

  Widget buildSplashText(BuildContext context) {
    return Center(
      child: TypeThis(
        textAlign: TextAlign.center,
        string: myAppName,
        speed: animationSpeed,
        showBlinkingCursor: false,
        style: context.textTheme.headlineSmall?.copyWith(
          color: context.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
