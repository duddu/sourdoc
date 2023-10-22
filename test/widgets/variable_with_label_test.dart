import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/widgets/header.dart';
import 'package:sourdoc/widgets/variable_with_label.dart';

import 'helpers/get_widget_with_test_scaffold.dart';

void main() {
  group('VariableWithLabel', () {
    const String label = 'variable test label';
    const double value = 10.43123;
    const int fractionDigits = 2;
    const String unit = 'g';

    final valueWidget = Consumer(builder: (context, model, child) {
      return const VariableWithLabelValue(
          value: value, fractionDigits: fractionDigits, unit: unit);
    });

    final getTestWidget = getWidgetWithTestScaffold(
        VariableWithLabel(label: label, value: valueWidget));

    testWidgets('should have a label', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(find.textContaining(label), findsOneWidget);
    });

    testWidgets('should have a rounded value with unit', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(find.text('${value.toStringAsFixed(fractionDigits)}$unit'),
          findsOneWidget);
    });

    testWidgets('should have a semantic label on the value', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(
          find.descendant(
              of: find.byWidgetPredicate((widget) =>
                  widget is Semantics &&
                  widget.properties.label ==
                      locale.getA11yVariableValueLabel(label)),
              matching: find.byType(VariableWithLabelValue)),
          findsOneWidget);
    });

    testWidgets('should not display an info button by default', (tester) async {
      await tester.pumpWidget(getTestWidget);

      expect(find.byWidgetPredicate((Widget widget) => widget is InfoButton),
          findsNothing);
    });

    group('if additionalInfoText is provided', () {
      const String additionalInfoText = 'additional info test text';

      testWidgets('should display an info button', (tester) async {
        await tester.pumpWidget(getWidgetWithTestScaffold(VariableWithLabel(
          label: label,
          additionalInfoText: additionalInfoText,
          value: valueWidget,
        )));

        expect(find.byWidgetPredicate((Widget widget) => widget is InfoButton),
            findsOneWidget);
      });

      testWidgets('should open bottom sheet when info button is pressed',
          (tester) async {
        await tester.pumpWidget(getWidgetWithTestScaffold(VariableWithLabel(
          label: label,
          additionalInfoText: additionalInfoText,
          value: valueWidget,
        )));

        await tester.tap(
            find.byWidgetPredicate((Widget widget) => widget is InfoButton));
        await tester.pumpAndSettle();

        expect(
            find.descendant(
                of: find.byType(InfoBottomSheet),
                matching: find.widgetWithText(Header, label)),
            findsOneWidget);
        expect(
            find.descendant(
                of: find.byType(InfoBottomSheet),
                matching: find.text(additionalInfoText)),
            findsOneWidget);
      });
    });
  });
}
