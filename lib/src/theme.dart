import 'package:flutter/material.dart';

const prismSeedColor = Color(0xFF675496);
const prismSuccessColor = Color(0xFF2E7D32);
const prismWarningColor = Color(0xFFE65100);
const prismDangerColor = Color(0xFF8C1D18);

final prismLightColorScheme = ColorScheme.fromSeed(seedColor: prismSeedColor)
    .copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFF675496),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFF6EDFF),
      onPrimaryContainer: const Color(0xFF21005D),
      secondaryContainer: const Color(0xFFF7F2FA),
      onSecondaryContainer: const Color(0xFF1D1B20),
      surface: const Color(0xFFFFFBFE),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFFFFBFE),
      surfaceContainer: const Color(0xFFF7F2FA),
      surfaceContainerHigh: const Color(0xFFECE6F0),
      onSurface: const Color(0xFF1D1B20),
      onSurfaceVariant: const Color(0xFF79747E),
      outline: const Color(0xFFCAC4D0),
      outlineVariant: const Color(0xFFE7E0EC),
      error: prismDangerColor,
      errorContainer: const Color(0xFFFCEEEE),
      onErrorContainer: prismDangerColor,
    );

final prismDarkColorScheme =
    ColorScheme.fromSeed(
      seedColor: prismSeedColor,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFFD0BCFF),
      onPrimary: const Color(0xFF21005D),
      primaryContainer: const Color(0xFF4F378B),
      onPrimaryContainer: const Color(0xFFEADDFF),
      surface: const Color(0xFF1D1B20),
      surfaceContainerLowest: const Color(0xFF141218),
      surfaceContainerLow: const Color(0xFF1D1B20),
      surfaceContainer: const Color(0xFF2B2930),
      surfaceContainerHigh: const Color(0xFF36343B),
      onSurface: const Color(0xFFE6E0E4),
      onSurfaceVariant: const Color(0xFF938F99),
      outline: const Color(0xFF49454F),
      outlineVariant: const Color(0xFF2B2930),
      error: const Color(0xFFF2B8B5),
      errorContainer: const Color(0xFF8C1D18),
      onErrorContainer: const Color(0xFFFFDAD6),
    );

ThemeData buildPrismDashboardTheme(ColorScheme scheme) {
  final baseTextTheme = scheme.brightness == Brightness.dark
      ? Typography.material2021().white
      : Typography.material2021().black;
  final textTheme = baseTextTheme.apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(40, 36),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(40, 36),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerLowest,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surfaceContainer,
      indicatorColor: scheme.primaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: TextStyle(color: scheme.onInverseSurface),
    ),
  );
}
