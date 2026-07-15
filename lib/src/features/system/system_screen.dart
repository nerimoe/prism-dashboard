import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api_client.dart';
import '../../api/models.dart';
import '../../app_state.dart';
import '../../context_extensions.dart';
import '../../shared/admin_forms.dart';
import '../../shared/admin_layout.dart';
import '../../shared/admin_time_zone.dart';
import '../../shared/token_role_labels.dart';
import '../../shared/widgets.dart';

class SystemScreen extends ConsumerStatefulWidget {
  const SystemScreen({super.key, this.api, this.canWrite, this.role});

  final PrismApiClient? api;
  final bool? canWrite;
  final StaffRole? role;

  @override
  ConsumerState<SystemScreen> createState() => _SystemScreenState();
}

class _HaDeviceInput {
  _HaDeviceInput({
    required String name,
    required List<String> alias,
    required String id,
  }) : nameController = TextEditingController(text: name),
       aliasController = TextEditingController(text: alias.join(', ')),
       idController = TextEditingController(text: id);

  final TextEditingController nameController;
  final TextEditingController aliasController;
  final TextEditingController idController;

  void dispose() {
    nameController.dispose();
    aliasController.dispose();
    idController.dispose();
  }
}

class _SystemScreenState extends ConsumerState<SystemScreen> {
  late Future<_SystemData> _future;
  final _storeNameController = TextEditingController();
  final _timeZoneController = TextEditingController();
  final List<_HaDeviceInput> _haDevices = [];
  int _coinCooldownMs = 1000;
  bool _settingsAdopted = false;
  String? _message;
  Map<String, dynamic> _rawSettings = const {};

  PrismApiClient get _api => widget.api ?? ref.read(apiClientProvider);

  bool get _canWrite =>
      widget.canWrite ??
      ref.watch(appControllerProvider).value?.staff?.canWrite ??
      true;

  StaffRole get _role =>
      widget.role ??
      ref.read(appControllerProvider).value?.staff?.role ??
      StaffRole.owner;

  bool get _isOwner => _role == StaffRole.owner;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _timeZoneController.dispose();
    for (final dev in _haDevices) {
      dev.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_SystemData>(
      future: _future,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null && !_settingsAdopted) _adoptSettings(data);
        return AdminWorkspace(
          title: '员工与系统',
          subtitle: '管理店铺设置、员工账号和外部接入密钥。',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_message != null) ...[
                _MessageBanner(
                  message: _message!,
                  onClose: () => setState(() => _message = null),
                ),
                const SizedBox(height: 12),
              ],
              if (!_canWrite) ...[
                const _PermissionNotice(),
                const SizedBox(height: 12),
              ],
              if (snapshot.connectionState != ConnectionState.done &&
                  data == null)
                const Center(child: CircularProgressIndicator())
              else if (snapshot.hasError)
                PrismPanel(
                  title: '系统设置没有加载成功',
                  subtitle: snapshot.error.toString(),
                  trailing: IconButton(
                    tooltip: '重试',
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                  ),
                  child: const SizedBox.shrink(),
                )
              else if (data != null)
                DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: '店铺设置', icon: Icon(Icons.store)),
                          Tab(text: '员工权限', icon: Icon(Icons.group)),
                          Tab(text: '接入密钥', icon: Icon(Icons.key)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 750,
                        child: TabBarView(
                          children: [
                            _SettingsTab(
                              storeNameController: _storeNameController,
                              timeZoneController: _timeZoneController,
                              haDevices: _haDevices,
                              onAddDevice: () {
                                setState(() {
                                  _haDevices.add(
                                    _HaDeviceInput(name: '', alias: [], id: ''),
                                  );
                                });
                              },
                              onDeleteDevice: (index) {
                                setState(() {
                                  final dev = _haDevices.removeAt(index);
                                  dev.dispose();
                                });
                              },
                              coinCooldownMs: _coinCooldownMs,
                              canWrite: _canWrite,
                              onCooldownChanged: (value) =>
                                  setState(() => _coinCooldownMs = value),
                              onSave: _saveSettings,
                            ),
                            _StaffTab(
                              users: data.staffUsers,
                              canView: _isOwner,
                              canWrite: _isOwner,
                              onCreate: _showCreateStaffDialog,
                              onEdit: _showEditStaffDialog,
                              onResetPassword: _showResetPasswordDialog,
                            ),
                            _TokensTab(
                              tokens: data.apiTokens,
                              canView: _isOwner,
                              canWrite: _isOwner,
                              onCreate: _showCreateTokenDialog,
                              onRevoke: _revokeToken,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<_SystemData> _load() async {
    final results = await Future.wait<Object>([
      _api.getRawSettings(),
      if (_isOwner)
        _api.listStaffUsers()
      else
        Future<List<StaffUser>>.value(const []),
      if (_isOwner)
        _api.listApiTokens()
      else
        Future<List<ApiToken>>.value(const []),
    ]);
    final rawSettings = results[0] as Map<String, dynamic>;
    return _SystemData(
      settings: SettingsData.fromJson(rawSettings),
      rawSettings: rawSettings,
      staffUsers: results[1] as List<StaffUser>,
      apiTokens: results[2] as List<ApiToken>,
    );
  }

  void _adoptSettings(_SystemData data) {
    _rawSettings = Map<String, dynamic>.from(data.rawSettings);
    setAdminTimeZone(data.settings.timeZone);
    _storeNameController.text = data.settings.storeName;
    _timeZoneController.text = data.settings.timeZone;
    _coinCooldownMs = data.settings.coinCooldownMs;

    for (final dev in _haDevices) {
      dev.dispose();
    }
    _haDevices.clear();

    final haDevices = data.rawSettings['homeAssistantDevices'] ?? [];
    for (final dev in haDevices) {
      if (dev is Map) {
        final aliases =
            (dev['alias'] as List?)?.map((e) => e.toString()).toList() ?? [];
        _haDevices.add(
          _HaDeviceInput(
            name: dev['name']?.toString() ?? '',
            alias: aliases,
            id: dev['id']?.toString() ?? '',
          ),
        );
      }
    }

    _settingsAdopted = true;
  }

  void _refresh() {
    setState(() {
      _settingsAdopted = false;
      _future = _load();
    });
  }

  Future<void> _saveSettings() async {
    final haDevicesJson = _haDevices.map((dev) {
      final aliases = dev.aliasController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      return {
        'name': dev.nameController.text.trim(),
        'alias': aliases,
        'id': dev.idController.text.trim(),
      };
    }).toList();

    try {
      final updatedSettings = Map<String, dynamic>.from(_rawSettings)
        ..['store'] = {
          'name': _storeNameController.text.trim(),
          'timeZone': _timeZoneController.text.trim(),
        }
        ..['operations'] = {'coinCooldownMs': _coinCooldownMs}
        ..['homeAssistantDevices'] = haDevicesJson;
      await _api.updateRawSettings(updatedSettings);
      setState(() {
        _message = '店铺设置已保存。';
        _settingsAdopted = false;
        _future = _load();
      });
    } catch (e) {
      setState(() {
        _message = '⚠️ 保存失败：${e.toString()}';
      });
    }
  }

  Future<void> _showCreateStaffDialog() async {
    final username = TextEditingController();
    final displayName = TextEditingController();
    final password = TextEditingController();
    var role = StaffRole.viewer;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('添加员工'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: username,
                decoration: const InputDecoration(labelText: '登录名'),
              ),
              TextField(
                controller: displayName,
                decoration: const InputDecoration(labelText: '员工姓名'),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(labelText: '初始密码'),
              ),
              DropdownButtonFormField<StaffRole>(
                initialValue: role,
                decoration: const InputDecoration(labelText: '权限'),
                items: StaffRole.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_roleLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => role = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () async {
                await _api.createStaffUser(
                  username: username.text.trim(),
                  displayName: displayName.text.trim(),
                  role: role.name,
                  password: password.text,
                );
                if (context.mounted) Navigator.pop(context);
                setState(() {
                  _message = '员工账号已添加。';
                  _future = _load();
                });
              },
              child: const Text('添加'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditStaffDialog(StaffUser user) async {
    final displayName = TextEditingController(text: user.displayName);
    var role = user.role;
    var isArchived = user.isArchived;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('编辑 ${user.displayName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: displayName,
                decoration: const InputDecoration(labelText: '员工姓名'),
              ),
              DropdownButtonFormField<StaffRole>(
                initialValue: role,
                decoration: const InputDecoration(labelText: '权限'),
                items: StaffRole.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_roleLabel(value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setDialogState(() => role = value);
                },
              ),
              SwitchListTile(
                value: !isArchived,
                title: const Text('允许登录'),
                onChanged: (value) => setDialogState(() => isArchived = !value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: () async {
                await _api.updateStaffUser(
                  user.id,
                  displayName: displayName.text.trim(),
                  role: role.name,
                  isArchived: isArchived,
                );
                if (context.mounted) Navigator.pop(context);
                setState(() {
                  _message = '员工信息已保存。';
                  _future = _load();
                });
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showResetPasswordDialog(StaffUser user) async {
    final password = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('重置 ${user.displayName} 的密码'),
        content: TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(labelText: '新密码'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              await _api.resetStaffUserPassword(
                user.id,
                password: password.text,
              );
              if (context.mounted) Navigator.pop(context);
              setState(() => _message = '登录密码已重置。');
            },
            child: const Text('重置密码'),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateTokenDialog() async {
    final label = TextEditingController();
    var role = 'integration';
    var isSubmitting = false;
    String? errorMessage;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('新建接入密钥'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: label,
                decoration: const InputDecoration(labelText: '用途名称'),
              ),
              DropdownButtonFormField<String>(
                initialValue: role,
                decoration: const InputDecoration(labelText: '用途'),
                items: const [
                  DropdownMenuItem(
                    value: 'integration',
                    child: Text('机器人/店内入口'),
                  ),
                  DropdownMenuItem(value: 'machine', child: Text('机器软件接入')),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => role = value);
                },
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting ? null : () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: isSubmitting
                  ? null
                  : () async {
                      setDialogState(() {
                        isSubmitting = true;
                        errorMessage = null;
                      });
                      try {
                        final token = await _api.createApiToken(
                          label: label.text.trim(),
                          role: role,
                        );
                        if (context.mounted) Navigator.pop(context);
                        setState(() {
                          _message = '接入密钥已创建。';
                          _future = _load();
                        });
                        if (mounted) await _showTokenSecret(token);
                      } catch (error) {
                        if (!context.mounted) return;
                        setDialogState(() {
                          isSubmitting = false;
                          errorMessage = '创建失败：${_friendlyError(error)}';
                        });
                      }
                    },
              child: isSubmitting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('创建'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTokenSecret(ApiToken token) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('请保存这串密钥'),
        content: SelectableText(token.token ?? '密钥只会在创建后显示一次。'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('我已保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _revokeToken(ApiToken token) async {
    await _api.revokeApiToken(token.id);
    setState(() {
      _message = '接入密钥已撤销。';
      _future = _load();
    });
  }
}

String _friendlyError(Object error) {
  if (error is PrismApiException) return error.message;
  return error.toString();
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab({
    required this.storeNameController,
    required this.timeZoneController,
    required this.haDevices,
    required this.onAddDevice,
    required this.onDeleteDevice,
    required this.coinCooldownMs,
    required this.canWrite,
    required this.onCooldownChanged,
    required this.onSave,
  });

  final TextEditingController storeNameController;
  final TextEditingController timeZoneController;
  final List<_HaDeviceInput> haDevices;
  final VoidCallback onAddDevice;
  final ValueChanged<int> onDeleteDevice;
  final int coinCooldownMs;
  final bool canWrite;
  final ValueChanged<int> onCooldownChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '店铺设置',
      subtitle: '这些设置会影响员工后台和设备指令节奏。',
      trailing: FilledButton.icon(
        onPressed: canWrite ? onSave : null,
        icon: const Icon(Icons.save),
        label: const Text('保存设置'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: storeNameController,
            enabled: canWrite,
            decoration: const InputDecoration(labelText: '店铺名称'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: timeZoneController,
            enabled: canWrite,
            decoration: const InputDecoration(labelText: '营业时区'),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Home Assistant 设备映射',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (canWrite)
                TextButton.icon(
                  onPressed: onAddDevice,
                  icon: const Icon(Icons.add),
                  label: const Text('添加设备'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (haDevices.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  '暂无绑定的 Home Assistant 设备',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ),
              ),
            )
          else
            ...List.generate(haDevices.length, (index) {
              final dev = haDevices[index];
              return Padding(
                key: ValueKey(dev),
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: dev.nameController,
                            enabled: canWrite,
                            decoration: const InputDecoration(
                              labelText: '设备名称',
                              hintText: '例如：中二官拆',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: dev.aliasController,
                            enabled: canWrite,
                            decoration: const InputDecoration(
                              labelText: '别名 (英文逗号分隔)',
                              hintText: '例如：chu2, gc',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: dev.idController,
                            enabled: canWrite,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Home Assistant 实体 ID',
                              hintText: '例如：switch.cuco_cn_...',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        if (canWrite) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () => onDeleteDevice(index),
                            icon: Icon(
                              Icons.delete_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            tooltip: '删除设备',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          const SizedBox(height: 24),
          StepperNumberField(
            label: '投币间隔',
            value: coinCooldownMs,
            min: 0,
            max: 60000,
            step: 500,
            onChanged: canWrite ? onCooldownChanged : (_) {},
          ),
        ],
      ),
    );
  }
}

class _StaffTab extends StatelessWidget {
  const _StaffTab({
    required this.users,
    required this.canView,
    required this.canWrite,
    required this.onCreate,
    required this.onEdit,
    required this.onResetPassword,
  });

  final List<StaffUser> users;
  final bool canView;
  final bool canWrite;
  final VoidCallback onCreate;
  final ValueChanged<StaffUser> onEdit;
  final ValueChanged<StaffUser> onResetPassword;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '员工权限',
      subtitle: '维护店主、店长和店员账号。',
      trailing: FilledButton.icon(
        onPressed: canView && canWrite ? onCreate : null,
        icon: const Icon(Icons.person_add),
        label: const Text('添加员工'),
      ),
      child: !canView
          ? const EmptyState(
              icon: Icons.admin_panel_settings_outlined,
              title: '仅店主可管理员工',
              message: '店长和只读员工仍可使用其有权访问的店铺设置与接入密钥。',
            )
          : users.isEmpty
          ? const EmptyState(
              icon: Icons.group,
              title: '还没有员工账号',
              message: '添加员工后，就可以分配后台权限。',
            )
          : Column(
              children: [
                for (final user in users)
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: Text(user.displayName),
                    subtitle: Text(
                      '${user.username} · ${_roleLabel(user.role)}',
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        StaffUserStatusPill(isArchived: user.isArchived),
                        IconButton(
                          tooltip: '编辑',
                          onPressed: canWrite ? () => onEdit(user) : null,
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          tooltip: '重置密码',
                          onPressed: canWrite
                              ? () => onResetPassword(user)
                              : null,
                          icon: const Icon(Icons.lock_reset),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _TokensTab extends StatelessWidget {
  const _TokensTab({
    required this.tokens,
    required this.canView,
    required this.canWrite,
    required this.onCreate,
    required this.onRevoke,
  });

  final List<ApiToken> tokens;
  final bool canView;
  final bool canWrite;
  final VoidCallback onCreate;
  final ValueChanged<ApiToken> onRevoke;

  @override
  Widget build(BuildContext context) {
    return PrismPanel(
      title: '接入密钥',
      subtitle: '给设备网关或外部服务使用，创建后密钥只显示一次。',
      trailing: FilledButton.icon(
        onPressed: canView && canWrite ? onCreate : null,
        icon: const Icon(Icons.add),
        label: const Text('新建密钥'),
      ),
      child: !canView
          ? const EmptyState(
              icon: Icons.key_outlined,
              title: '仅店主可管理接入密钥',
              message: '接入密钥可以控制机器人入口和机器软件，请联系店主创建或撤销。',
            )
          : tokens.isEmpty
          ? const EmptyState(
              icon: Icons.key,
              title: '还没有接入密钥',
              message: '新建设备或外部系统接入时再创建。',
            )
          : Column(
              children: [
                for (final token in tokens)
                  ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: Text(token.label),
                    subtitle: Text(
                      '${tokenRoleLabel(token.role)} · 前缀 ${token.tokenPrefix}',
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        ApiTokenStatusPill(isRevoked: token.isRevoked),
                        TextButton(
                          onPressed: canWrite && !token.isRevoked
                              ? () => onRevoke(token)
                              : null,
                          child: const Text('撤销'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _PermissionNotice extends StatelessWidget {
  const _PermissionNotice();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '当前账号只能查看设置，需要店长或店主权限才能修改。',
          style: context.text.bodyMedium?.copyWith(
            color: context.colors.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({required this.message, required this.onClose});

  final String message;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primaryContainer,
      child: ListTile(
        title: Text(message),
        trailing: IconButton(
          tooltip: '关闭',
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}

class _SystemData {
  const _SystemData({
    required this.settings,
    required this.rawSettings,
    required this.staffUsers,
    required this.apiTokens,
  });

  final SettingsData settings;
  final Map<String, dynamic> rawSettings;
  final List<StaffUser> staffUsers;
  final List<ApiToken> apiTokens;
}

String _roleLabel(StaffRole role) => switch (role) {
  StaffRole.owner => '店主',
  StaffRole.manager => '店长',
  StaffRole.viewer => '店员',
};
