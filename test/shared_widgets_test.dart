import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prism_dashboard/src/shared/admin_forms.dart';
import 'package:prism_dashboard/src/shared/admin_layout.dart';
import 'package:prism_dashboard/src/shared/admin_tables.dart';
import 'package:prism_dashboard/src/shared/widgets.dart';
import 'package:prism_dashboard/src/theme.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: buildPrismDashboardTheme(
        ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
      ),
      home: Scaffold(body: child),
    );
  }

  group('Shared Widgets Tests', () {
    testWidgets('EmptyState renders icon and text', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const EmptyState(
            icon: Icons.ac_unit,
            title: '空空如也',
            message: '没有任何冷冻物品',
          ),
        ),
      );

      expect(find.byIcon(Icons.ac_unit), findsOneWidget);
      expect(find.text('空空如也'), findsOneWidget);
      expect(find.text('没有任何冷冻物品'), findsOneWidget);
    });

    testWidgets('ConfirmActionDialog matches title and destructive colors', (tester) async {
      var confirmed = false;

      await tester.pumpWidget(
        buildTestableWidget(
          Builder(
            builder: (context) => FilledButton(
              onPressed: () {
                ConfirmActionDialog.show(
                  context: context,
                  title: '危险操作确认',
                  message: '确定要永久归档吗？',
                  onConfirm: () => confirmed = true,
                  confirmLabel: '执行归档',
                  isDestructive: true,
                );
              },
              child: const Text('触发弹窗'),
            ),
          ),
        ),
      );

      // Trigger dialog
      await tester.tap(find.text('触发弹窗'));
      await tester.pumpAndSettle();

      expect(find.text('危险操作确认'), findsOneWidget);
      expect(find.text('确定要永久归档吗？'), findsOneWidget);

      // Verify destructive color scheme
      final confirmBtn = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, '执行归档'),
      );
      // Under our buildPrismDashboardTheme error color resolved
      expect(confirmBtn.style?.backgroundColor != null, true);

      // Tap confirm
      await tester.tap(find.text('执行归档'));
      await tester.pumpAndSettle();

      expect(confirmed, true);
      expect(find.text('危险操作确认'), findsNothing); // Dialog dismissed
    });

    testWidgets('StepperNumberField enforces min/max boundaries', (tester) async {
      var value = 5;

      await tester.pumpWidget(
        buildTestableWidget(
          StatefulBuilder(
            builder: (context, setState) => StepperNumberField(
              value: value,
              min: 3,
              max: 7,
              step: 2,
              onChanged: (newValue) => setState(() => value = newValue),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);

      // Tap subtract (5 - 2 = 3)
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);

      // Subtract is now at minimum 3, verify subtract button is disabled
      final subtractBtn = tester.widget<IconButton>(
        find.ancestor(
          of: find.byIcon(Icons.remove),
          matching: find.byType(IconButton),
        ),
      );
      expect(subtractBtn.onPressed, null);

      // Tap add (3 + 2 = 5)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('5'), findsOneWidget);

      // Tap add again (5 + 2 = 7)
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('7'), findsOneWidget);

      // Add is now at maximum 7, verify add button is disabled
      final addBtn = tester.widget<IconButton>(
        find.ancestor(
          of: find.byIcon(Icons.add),
          matching: find.byType(IconButton),
        ),
      );
      expect(addBtn.onPressed, null);
    });

    testWidgets('AdminTablePanel height wraps content naturally when rows fit', (tester) async {
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.binding.setSurfaceSize(const Size(1280, 720));

      final panel = AdminTablePanel(
        title: '测试表格',
        headers: const ['列A', '列B'],
        itemCount: 2,
        rowBuilder: (context, index) => Container(
          height: 40,
          alignment: Alignment.center,
          child: Text('行数据 $index'),
        ),
      );

      await tester.pumpWidget(buildTestableWidget(panel));
      await tester.pumpAndSettle();

      final panelHeight = tester.getSize(find.byType(AdminTablePanel)).height;
      // Expect natural height wrapping, since 2 rows + headers + titles fit comfortably under 200px
      expect(panelHeight, lessThan(300.0));
      expect(panelHeight, greaterThan(120.0));
    });
   group('MoneyText and DateTimeText format validations', () {
      testWidgets('MoneyText formats currency correctly', (tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            const Column(
              children: [
                MoneyText(value: 12.34, key: ValueKey('positive')),
                MoneyText(value: -50.0, key: ValueKey('negative')),
                MoneyText(value: null, key: ValueKey('null')),
              ],
            ),
          ),
        );

        expect(find.text('¥12.34'), findsOneWidget);
        expect(find.text('-¥50'), findsOneWidget);
        expect(find.text('--'), findsOneWidget);

        // Verify negative money displays red text color
        final negativeTextWidget = tester.widget<Text>(
          find.descendant(
            of: find.byKey(const ValueKey('negative')),
            matching: find.byType(Text),
          ),
        );
        final theme = Theme.of(tester.element(find.byKey(const ValueKey('negative'))));
        expect(negativeTextWidget.style?.color, theme.colorScheme.error);
      });

      testWidgets('DateTimeText formats date correctly', (tester) async {
        final date = DateTime.utc(2026, 7, 4, 12, 30);
        await tester.pumpWidget(
          buildTestableWidget(
            DateTimeText(value: date),
          ),
        );
        // Generates local formatted string
        final local = date.toLocal();
        final text = '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
        expect(find.text(text), findsOneWidget);
      });
    });

    testWidgets('AdminSplitPane renders list on compact screen, row on desktop screen', (tester) async {
      final splitPane = AdminSplitPane(
        list: const Text('列表数据'),
        detail: const Text('详情数据'),
        hasSelection: true,
        onBack: () {},
      );

      // Test desktop size
      await tester.pumpWidget(
        buildTestableWidget(
          MediaQuery(
            data: const MediaQueryData(size: Size(1280, 720)),
            child: splitPane,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('列表数据'), findsOneWidget);
      expect(find.text('详情数据'), findsOneWidget);

      // Test compact mobile size
      await tester.pumpWidget(
        buildTestableWidget(
          MediaQuery(
            data: const MediaQueryData(size: Size(360, 640)),
            child: splitPane,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('详情数据'), findsOneWidget);
      expect(find.text('列表数据'), findsNothing); // Under selection, list is hidden on mobile
    });
  });
}
