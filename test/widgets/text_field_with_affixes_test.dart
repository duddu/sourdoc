import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/widgets/text_field_with_affixes.dart';
import 'package:sourdoc/constants/locale.dart' as locale;

import 'helpers/get_widget_with_test_scaffold.dart';

const String testInitialValue = '10';
const String testPrefixText = 'test prefix';
const String testSuffixText = 'test suffix';
const String testTooltip = 'test tooltip';
const double testMaxValue = 100;

int _counter = 0;

class TestTextField extends StatefulWidget {
  TestTextField({super.key});

  final TextEditingController controller =
      TextEditingController(text: testInitialValue);

  @override
  State<TestTextField> createState() => _TestTextFieldState();
}

class _TestTextFieldState extends State<TestTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldWithAffixes(
      controller: widget.controller,
      prefixText: testPrefixText,
      suffixText: testSuffixText,
      tooltip: testTooltip,
      maxValue: testMaxValue,
      onChangedCallback: () {
        _counter++;
      },
    );
  }
}

void main() {
  group('TextFieldWithAffixes', () {
    testWidgets('should have an initial value', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.controller?.text != null &&
              widget.controller!.text == testInitialValue),
          findsOneWidget);
    });

    testWidgets('should have a prefix text', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration?.prefixText != null &&
              widget.decoration!.prefixText!.contains(testPrefixText)),
          findsOneWidget);
    });

    testWidgets('should have a suffix text', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration?.suffixText != null &&
              widget.decoration!.suffixText == testSuffixText),
          findsOneWidget);
    });

    testWidgets('should have a tooltip text', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Tooltip &&
              widget.message != null &&
              widget.message == testTooltip),
          findsOneWidget);
    });

    testWidgets('should call the on change callback', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(_counter, 0);
      await tester.enterText(find.byType(TextField), '123');
      expect(_counter, 1);
    });

    testWidgets('should apply default padding top', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Padding &&
              widget.padding ==
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 5)),
          findsOneWidget);
    });

    testWidgets('should apply custom padding top', (tester) async {
      final testTextField = TextFieldWithAffixes(
        controller: TextEditingController(text: testInitialValue),
        prefixText: testPrefixText,
        suffixText: testSuffixText,
        tooltip: testTooltip,
        maxValue: testMaxValue,
        paddingTop: 10,
        onChangedCallback: () {},
      );
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Padding &&
              widget.padding == const EdgeInsets.fromLTRB(0, 10, 0, 5)),
          findsOneWidget);
    });

    testWidgets('should select all text on focus', (tester) async {
      final testTextField = TestTextField();
      await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));
      await tester.tap(find.byType(TextField));
      await tester.pump();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.controller?.selection != null &&
              widget.controller!.selection ==
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: widget.controller!.value.text.length)),
          findsOneWidget);
    });

    group('when input exceeds max value', () {
      testWidgets('should replace text with max value', (tester) async {
        final testTextField = TestTextField();
        await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));
        await tester.enterText(
            find.byType(TextField), (testMaxValue + 1).toString());
        await tester.pump();

        expect(
            find.byWidgetPredicate((Widget widget) =>
                widget is TextField &&
                widget.controller?.text != null &&
                widget.controller!.text == testMaxValue.toStringAsFixed(1)),
            findsOneWidget);
      });

      testWidgets('should display error snack bar', (tester) async {
        final testTextField = TestTextField();
        await tester.pumpWidget(getWidgetWithTestScaffold(testTextField));
        await tester.enterText(
            find.byType(TextField), (testMaxValue + 1).toString());
        await tester.pump();

        expect(find.text(locale.getInputErrorMessage(testMaxValue)),
            findsOneWidget);
      });
    });
  });
}
