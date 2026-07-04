import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '资产与礼包',
            subtitle: '管理店内通用的代币、礼包模版和兑换码（CDK）。',
            child: EmptyState(
              icon: Icons.inventory_2,
              title: '暂无资产配置数据',
              message: '加载中或未添加任何资产类型',
            ),
          ),
        ],
      ),
    );
  }
}
