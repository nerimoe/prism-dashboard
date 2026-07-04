import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class SystemScreen extends StatelessWidget {
  const SystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '员工与系统',
            subtitle: '管理店铺基本配置、店员操作权限与 API 接入令牌。',
            child: EmptyState(
              icon: Icons.admin_panel_settings,
              title: '设置项加载中',
              message: '从系统安全网关获取权限列表中…',
            ),
          ),
        ],
      ),
    );
  }
}
