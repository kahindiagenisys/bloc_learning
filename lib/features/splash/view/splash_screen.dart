import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
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

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;

    return Scaffold(
      backgroundColor: color.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task,
            size: 100,
            color: color.onPrimary,
          ),
          20.height,
          Center(
            child: TypeThis(
              textAlign: TextAlign.center,
              string: myAppName,
              speed: animationSpeed,
              showBlinkingCursor: false,
              style: context.textTheme.headlineSmall?.copyWith(
                color: color.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
