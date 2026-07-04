import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '服务项目与订单',
            subtitle: '管理饮料、零食、商品和包厢等非计时服务项目的销售及订单。',
            child: EmptyState(
              icon: Icons.room_service,
              title: '暂无订单记录',
              message: '玩家尚未购买任何服务项目',
            ),
          ),
        ],
      ),
    );
  }
}
