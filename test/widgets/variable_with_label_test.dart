import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';

import 'helpers/get_widget_with_test_scaffold.dart';
import 'helpers/ignore_overflow_errors.dart';

void main() {
  group('VariableWithLabel', () {
    const String label = 'variable test label';
    const double value = 10.43123;
    const int fractionDigits = 2;
    const String unit = 'g';

    final getTestWidget = getWidgetWithTestScaffold(const VariableWithLabel(
      label: label,
      value: value,
      fractionDigits: fractionDigits,
      unit: unit,
    ));

    testWidgets('should have a label', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(find.textContaining(label), findsOneWidget);
    });

    testWidgets('should have a rounded value with unit', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(find.text('${value.toStringAsFixed(fractionDigits)}$unit'),
          findsOneWidget);
    });

    testWidgets('should not have an InfoButton by default', (tester) async {
      await tester.pumpWidget(getTestWidget);

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
          fractionDigits: fractionDigits,
          unit: unit,
          additionalInfoText: additionalInfoText,
        )));

        expect(find.byWidgetPredicate((Widget widget) => widget is InfoButton),
            findsOneWidget);
      });
    });
  });
}
