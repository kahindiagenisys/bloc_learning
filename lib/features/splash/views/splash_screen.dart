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
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final animationSpeed = 200;

  final _splash = injection<SplashBloc>();

  @override
  void initState() {
    _splash.add(
      SplashInitialEvent(
        appNameLength: myAppName.length,
        animationSpeed: 200,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _splash,
      child: BlocListener<SplashBloc, SplashStatusState>(
        listener: _splashBlocListen,
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSplashIcon(context),
              20.height,
              buildSplashText(context),
            ],
          ),
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

  void _splashBlocListen(BuildContext context, SplashStatusState state) {
    if (state == SplashStatusState.navigateToHome) {
      context.router.replaceAll([const HomeRoute()]);
    } else if (state == SplashStatusState.navigateToLogin) {
      context.router.replaceAll([const SingInRoute()]);
    }
  }
}
