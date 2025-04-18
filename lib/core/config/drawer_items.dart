import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_booster/core/constants/constant.dart';
import 'package:health_booster/core/theme/app_theme.dart' show AppTheme;
import 'package:health_booster/features/sign_in/bloc/sign_in_bloc.dart';
import 'package:health_booster/injection.dart';
import 'package:health_booster/routes/app_route.dart';
import 'package:lucide_icons/lucide_icons.dart' show LucideIcons;
import 'package:nb_utils/nb_utils.dart';

List<DrawerItem> getDrawerItems() {
  return [
    DrawerItem(
      title: "Logout",
      icon: LucideIcons.logOut,
      color: AppTheme.appFlexSchemeColor.data.dark.error,
      onTap: (BuildContext context) async {
        final isLogOut = await showConfirmDialog(
          context,
          logOutConformationMessage,
        );

        if (!isLogOut) return;

        /// TODO: The login hasn't been implemented in the proper way. Ideally, the main screen should handle navigation to
        /// - either the login screen or the home screen based on the authentication state. However, it's manageable for now.

        injection<SignInBloc>().logout();

        if (context.mounted) {
          context.router.replaceAll([const SignInRoute()]);
        }
      },
    ),
  ];
}

typedef DrawerItemCallback = void Function();

class DrawerItem {
  final String title;
  final IconData icon;
  final Color? color;
  final Function(BuildContext context) onTap;

  const DrawerItem({
    required this.title,
    required this.icon,
    this.color,
    required this.onTap,
  });
}
