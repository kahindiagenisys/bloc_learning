import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_booster/core/config/drawer_items.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:health_booster/core/theme/app_fonts.dart';
import 'package:health_booster/features/profile/bloc/profile_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          ...getDrawerItems().map(
            (item) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: item.color?.withValues(alpha: 0.5),
                  child: Icon(item.icon, size: 18),
                ),
                title: Text(item.title),
                onTap: () => item.onTap(context),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final color = context.colorScheme;
    return DrawerHeader(
      decoration: BoxDecoration(
        color: color.primary,
      ), // BoxDecoration
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final user = state.user!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                        user.email[0].toUpperCase(),
                        style: AppFonts.subtitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  user.fullName,
                  style: AppFonts.title.copyWith(color: color.onPrimary),
                ),
                const SizedBox(height: 5),
                Text(
                  user.email,
                  style: AppFonts.caption.copyWith(color: color.onPrimary),
                ),
              ],
            );
          } else {
            return const SizedBox(
              width: double.infinity,
            );
          }
        },
      ),
    );
  }
}
