import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/theme.dart';

void main() {
  runApp(const ProviderScope(child: PrismDashboardBootstrap()));
}

class PrismDashboardBootstrap extends StatelessWidget {
  const PrismDashboardBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return PrismDashboardApp(
      lightTheme: buildPrismDashboardTheme(prismLightColorScheme),
      darkTheme: buildPrismDashboardTheme(prismDarkColorScheme),
    );
  }
}
