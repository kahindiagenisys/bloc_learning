import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:health_booster/core/theme/app_fonts.dart';

class AppTheme {
  // 👇 Private constructor to prevent instantiation
  const AppTheme._();

  // 🎨 Define the primary Flex color scheme for the app (using built-in blue tones)
  static const appFlexSchemeColor = FlexScheme.blue;

  // 🎨 Custom SchemeColor used for TabBar & FAB foreground/background
  static const _onPrimaryColor = SchemeColor.onPrimary;

  // ⚙️ Common sub-theme configuration used in both light & dark modes
  static const _subThemesData = FlexSubThemesData(
    blendOnColors: true,
    // blend primary colors with background surface
    cardElevation: 0,
    // cards have flat design (no shadow)
    inputDecoratorUnfocusedHasBorder: false,
    // hide border when input not focused
    inputDecoratorFocusedHasBorder: false,
    // hide border when input is focused too
    fabAlwaysCircular: true,
    // FloatingActionButton always circular
    fabUseShape: true,
    // FAB will respect theme shape
    fabSchemeColor: SchemeColor.primaryContainer,
    // FAB background color
    cardRadius: 10,
    // rounded corner for cards
    bottomAppBarHeight: 60,
    // custom height for BottomAppBar
    tabBarDividerColor: Colors.transparent,
    // removes divider line under TabBar
    tabBarIndicatorTopRadius: 8,
    // top rounded underline indicator on tabs
    tabBarIndicatorWeight: 3.5,
    // thickness of TabBar indicator
    tabBarUnselectedItemOpacity: 0.5,
    // fade effect on unselected tab labels
    tabBarItemSchemeColor: _onPrimaryColor,
    // selected tab item color
    tabBarIndicatorSchemeColor: _onPrimaryColor,
    // color of the tab indicator
    tabBarIndicatorSize: TabBarIndicatorSize.label,
    // indicator size matches label
    tabBarUnselectedItemSchemeColor:
        _onPrimaryColor, // color of unselected tab items
  );

  // 🌞 Light theme config
  static final light = FlexThemeData.light(
    scheme: appFlexSchemeColor,
    // primary color scheme
    textTheme: AppFonts.getAppTextTheme(Brightness.light),
    // Inter font with brightness-aware styling
    subThemesData: _subThemesData,
    // apply all sub theme tweaks
    visualDensity: FlexColorScheme
        .comfortablePlatformDensity, // responsive spacing for all platforms
  );

  // 🌙 Dark theme config
  static final dark = FlexThemeData.dark(
    scheme: appFlexSchemeColor,
    // primary color scheme
    textTheme: AppFonts.getAppTextTheme(Brightness.dark),
    // Inter font with brightness-aware styling
    subThemesData: _subThemesData,
    // same sub-theme as light mode
    visualDensity:
        FlexColorScheme.comfortablePlatformDensity, // responsive spacing
  );
}
