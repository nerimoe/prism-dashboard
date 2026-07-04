import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('feature UI string literals avoid developer-facing words', () {
    final featureDir = Directory('lib/src/features');
    final forbidden = [
      'provider',
      'subject',
      'metadata',
      'session',
      'payload',
      'iso',
      'millisecond',
      'hh:mm',
    ];

    final offenders = <String>[];
    for (final file
        in featureDir
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart'))) {
      final source = file.readAsStringSync();
      final literals = RegExp(
        r''''([^'\\]*(?:\\.[^'\\]*)*)'|"([^"\\]*(?:\\.[^"\\]*)*)"''',
        multiLine: true,
      ).allMatches(source);
      for (final match in literals) {
        final literal = (match.group(1) ?? match.group(2) ?? '')
            .replaceAll(RegExp(r'\$\{[^}]*\}'), '')
            .replaceAll(RegExp(r'\$[A-Za-z_][A-Za-z0-9_]*'), '')
            .toLowerCase();
        for (final word in forbidden) {
          if (literal.contains(word)) {
            offenders.add('${file.path}: "$literal" contains "$word"');
          }
        }
      }
    }

    expect(offenders, isEmpty, reason: offenders.join('\n'));
  });
}
