import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '营业报表',
            subtitle: '统计选定时间范围内的营业收入、进客总数以及结算明细。',
            child: EmptyState(
              icon: Icons.bar_chart,
              title: '暂无报表数据',
              message: '请选择正确的日期范围进行查询',
            ),
          ),
        ],
      ),
    );
  }
}
