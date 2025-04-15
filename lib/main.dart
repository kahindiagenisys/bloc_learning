import 'package:flutter/material.dart';
import 'package:health_booster/core/theme/app_theme.dart';
import 'package:health_booster/injection.dart';
import 'package:health_booster/routes/app_route.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> main() async {
  await initialized();
  setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final brightness = context.platformBrightness();

    bool isLightBrightness = brightness == Brightness.light;
    return MaterialApp.router(
      title: "Health",
      theme: isLightBrightness ? AppTheme.light : AppTheme.dark,
      routerConfig: appRouter.config(),
    );
  }
}
