import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '计费配置',
            subtitle: '使用时段、日期和星期过滤配置灵活的计费规则。',
            child: EmptyState(
              icon: Icons.tune,
              title: '暂无计费配置',
              message: '添加新的优先级计费规则以启用计时收费',
            ),
          ),
        ],
      ),
    );
  }
}
