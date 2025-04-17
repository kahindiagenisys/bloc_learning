import 'package:flutter/material.dart';

void _closeKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void get closeKeyboard => _closeKeyboard();
