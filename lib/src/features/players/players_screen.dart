import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '玩家档案',
            subtitle: '管理店内注册玩家的基本信息、身份绑定与钱包余额。',
            child: EmptyState(
              icon: Icons.group,
              title: '暂未选中玩家',
              message: '点击玩家列表查看详细档案',
            ),
          ),
        ],
      ),
    );
  }
}
