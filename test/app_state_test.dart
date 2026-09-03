import 'package:flutter_test/flutter_test.dart';
import 'package:prism_dashboard/src/app_state.dart';

void main() {
  test('production dashboard does not guess an API URL', () {
    expect(defaultBaseUrlFor(Uri.parse('https://dashboard.example/admin')), '');
    expect(
      defaultBaseUrlFor(Uri.parse('http://localhost:5500')),
      'http://localhost:8787',
    );
  });
}
