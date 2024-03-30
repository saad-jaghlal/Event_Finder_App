import 'package:event_finder_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark();
  static final lightThemeMode = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPallete.whiteColor),
    useMaterial3: true,
  );
}

