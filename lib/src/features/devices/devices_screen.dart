import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrismPanel(
            title: '设备看板',
            subtitle: '查看门禁终端、投币控制器和智能网关的实时连接状态与运行指令日志。',
            child: EmptyState(
              icon: Icons.devices,
              title: '暂无在线设备',
              message: '请检查物联网网关连接状态',
            ),
          ),
        ],
      ),
    );
  }
}
