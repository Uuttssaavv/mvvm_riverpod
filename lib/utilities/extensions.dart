import 'package:flutter/material.dart';

extension StringInterpolation on String {
  String get capitalize => this[0].toUpperCase() + substring(1);
}

extension SpacingExtension on num {
  Widget get verticalSpacer => SizedBox(height: toDouble(), width: 0);
  Widget get horizontalSpacer => SizedBox(height: 0, width: toDouble());
}

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  TextTheme get textTheme => Theme.of(this).textTheme;
  void goBack() => Navigator.pop(this);
}
