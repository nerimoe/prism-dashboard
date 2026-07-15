import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_state.dart';
import '../../context_extensions.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, this.appState, this.initialError});

  final AppState? appState;
  final String? initialError;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _baseUrl = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _storeName = TextEditingController(text: 'PRiSM Store');
  final _displayName = TextEditingController(text: '店主');
  final _timeZone = TextEditingController(text: 'Asia/Shanghai');
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _baseUrl.text = widget.appState?.baseUrl ?? defaultBaseUrl;
    _error = widget.initialError;
  }

  @override
  void dispose() {
    _baseUrl.dispose();
    _username.dispose();
    _password.dispose();
    _storeName.dispose();
    _displayName.dispose();
    _timeZone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final installed = widget.appState?.isInstalled ?? true;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: context.colors.primary,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'prism_dashboard',
                    textAlign: TextAlign.center,
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    installed ? '登录后台，继续处理现场运营。' : '第一次使用前，先完成店铺初始化。',
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _baseUrl,
                    decoration: const InputDecoration(
                      labelText: '服务器地址',
                      prefixIcon: Icon(Icons.link),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 12),
                  if (!installed) ...[
                    TextField(
                      controller: _storeName,
                      decoration: const InputDecoration(
                        labelText: '店铺名称',
                        prefixIcon: Icon(Icons.storefront),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _displayName,
                      decoration: const InputDecoration(
                        labelText: '管理员显示名',
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _timeZone,
                      decoration: const InputDecoration(
                        labelText: '营业时区',
                        hintText: '例如 Asia/Shanghai',
                        prefixIcon: Icon(Icons.public),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextField(
                    controller: _username,
                    decoration: const InputDecoration(
                      labelText: '账号',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: '密码',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: TextStyle(color: context.colors.error),
                    ),
                  ],
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _busy
                        ? null
                        : () => installed ? _login() : _install(),
                    icon: _busy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.login),
                    label: Text(installed ? '登录' : '初始化并登录'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    await _run(() async {
      await ref
          .read(appControllerProvider.notifier)
          .updateBaseUrl(_baseUrl.text.trim());
      await ref
          .read(appControllerProvider.notifier)
          .login(username: _username.text.trim(), password: _password.text);
    });
  }

  Future<void> _install() async {
    await _run(() async {
      await ref
          .read(appControllerProvider.notifier)
          .updateBaseUrl(_baseUrl.text.trim());
      await ref
          .read(appControllerProvider.notifier)
          .install(
            storeName: _storeName.text.trim(),
            timeZone: _timeZone.text.trim(),
            username: _username.text.trim(),
            displayName: _displayName.text.trim(),
            password: _password.text,
            coinCooldownMs: 800,
          );
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (error) {
      setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}
