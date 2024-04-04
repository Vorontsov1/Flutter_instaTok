import 'package:flutter/material.dart';

extension UIThemeExtension on BuildContext {

  // * (default) TextTheme
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;
  TextStyle get labelMedium => Theme.of(this).textTheme.labelMedium!;
  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall!;
  

  // * (default) ColorScheme
  Color get background =>  Theme.of(this).colorScheme.background;
  Color get onBackground =>  Theme.of(this).colorScheme.onBackground;
  Color get primary =>  Theme.of(this).colorScheme.primary;
  Color get onPrimary =>  Theme.of(this).colorScheme.onPrimary;
  Color get secondary =>  Theme.of(this).colorScheme.secondary;
  Color get onSecondary =>  Theme.of(this).colorScheme.onSecondary;
  Color get error =>  Theme.of(this).colorScheme.error;
  Color get outline =>  Theme.of(this).colorScheme.outline;

}