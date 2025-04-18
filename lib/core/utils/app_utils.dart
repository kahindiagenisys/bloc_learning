import 'package:flutter/material.dart';
import 'package:health_booster/core/theme/app_theme.dart' show AppTheme;
import 'package:nb_utils/nb_utils.dart';

void _closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void get closeKeyboard => _closeKeyboard();

void showErrorMessage(String message) {
  toastLong(message, bgColor: AppTheme.appFlexSchemeColor.data.dark.error);
}

void showSuccessMessage(String message) {
  toastLong(message, bgColor: greenColor.withValues(alpha: 0.5));
}
