import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism_dashboard/src/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('production dashboard does not guess an API URL', () {
    expect(defaultBaseUrlFor(Uri.parse('https://dashboard.example/admin')), '');
    expect(
      defaultBaseUrlFor(Uri.parse('http://localhost:5500')),
      'http://localhost:8787',
    );
  });

  test('dashboard state is available before preferences finish loading', () {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appControllerProvider), isA<AsyncData<AppState>>());
  });
}
