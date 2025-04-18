import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_booster/features/home/views/widgets/app_drawer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
    );
  }
}
