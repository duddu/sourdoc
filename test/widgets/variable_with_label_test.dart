import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';

import 'helpers/get_widget_with_test_scaffold.dart';
import 'helpers/ignore_overflow_errors.dart';

void main() {
  group('VariableWithLabel', () {
    const String label = 'variable test label';
    const String value = 'variable test value';
    testWidgets('should have a label and a value', (tester) async {
      await tester.pumpWidget(getWidgetWithTestScaffold(
          const VariableWithLabel(label: label, value: value)));

      expect(find.textContaining(label), findsOneWidget);
      expect(find.text(value), findsOneWidget);
    });

    testWidgets('should not have an InfoButton by default', (tester) async {
      await tester.pumpWidget(getWidgetWithTestScaffold(
          const VariableWithLabel(label: label, value: value)));

      expect(find.byWidgetPredicate((Widget widget) => widget is InfoButton),
          findsNothing);
    });

    group('if additionalInfoText is provided', () {
      const String additionalInfoText = 'additional info test text';

      testWidgets('should have an InfoButton by default', (tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        await tester
            .pumpWidget(getWidgetWithTestScaffold(const VariableWithLabel(
          label: label,
          value: value,
          additionalInfoText: additionalInfoText,
        )));

        expect(find.byWidgetPredicate((Widget widget) => widget is InfoButton),
            findsOneWidget);
      });
    });
  });
}
