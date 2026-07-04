import 'package:flutter/material.dart';

extension PrismBuildContext on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  bool get isCompact => MediaQuery.sizeOf(this).width < 720;
  bool get isMedium => MediaQuery.sizeOf(this).width >= 720 && MediaQuery.sizeOf(this).width < 1180;
  bool get isExpanded => MediaQuery.sizeOf(this).width >= 1180;
}
