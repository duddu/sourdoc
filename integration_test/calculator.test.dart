import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/main.dart';
import 'package:sourdoc/methods/temperature_unit_helpers.dart';

void _expectCalculatorValues({
  required TemperatureUnit temperatureUnit,
  required String temperature,
  required String weight,
  required String hydration,
  required String saltLevel,
  required String flour,
  required String water,
  required String levain,
  required String salt,
  required String inoculation,
  required String rise,
}) {
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is SegmentedButton &&
          widget.selected.contains(temperatureUnit)),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is TextField &&
          widget.decoration!.prefixText ==
              '${locale.inputPrefixTemperature}:' &&
          widget.decoration!.suffixText ==
              getTemperatureUnitSymbol(temperatureUnit) &&
          widget.controller!.text == temperature),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is TextField &&
          widget.decoration!.prefixText == '${locale.inputPrefixWeight}:' &&
          widget.controller!.text == weight),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is TextField &&
          widget.decoration!.prefixText == '${locale.inputPrefixHydration}:' &&
          widget.controller!.text == hydration),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is TextField &&
          widget.decoration!.prefixText == '${locale.inputPrefixSalt}:' &&
          widget.controller!.text == saltLevel),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelFlour &&
          widget.data == flour),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelWater &&
          widget.data == water),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelLevain &&
          widget.data == levain),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelSalt &&
          widget.data == salt),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelInoculation &&
          widget.data == inoculation),
      findsOneWidget);
  expect(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelDoughRise &&
          widget.data == rise),
      findsOneWidget);
}

Future<void> _scrollUntilEnd(WidgetTester tester) async {
  await tester.scrollUntilVisible(
      find.byWidgetPredicate((Widget widget) =>
          widget is Text &&
          widget.semanticsLabel == locale.variableLabelDoughRise),
      50,
      scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Calculator', () {
    testWidgets('should load initial default values', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();
      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.celsius,
          temperature: '22',
          weight: '700',
          hydration: '70',
          saltLevel: '2',
          flour: '366.5g',
          water: '256.5g',
          levain: '69.6g',
          salt: '7.3g',
          inoculation: '19%',
          rise: '50%');
    });

    testWidgets('should switch to farenheit', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.degreesFarenheit));
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.farenheit,
          temperature: '71.6',
          weight: '700',
          hydration: '70',
          saltLevel: '2',
          flour: '366.5g',
          water: '256.5g',
          levain: '69.6g',
          salt: '7.3g',
          inoculation: '19%',
          rise: '50%');
    });

    testWidgets('should update values based on ambient temperature',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText ==
                  '${locale.inputPrefixTemperature}:'),
          '80');
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.farenheit,
          temperature: '80',
          weight: '700',
          hydration: '70',
          saltLevel: '2',
          flour: '375.7g',
          water: '263.0g',
          levain: '53.8g',
          salt: '7.5g',
          inoculation: '14%',
          rise: '25%');
    });

    testWidgets('should update values based on target bread weight',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText == '${locale.inputPrefixWeight}:'),
          '1350');
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.farenheit,
          temperature: '80',
          weight: '1350',
          hydration: '70',
          saltLevel: '2',
          flour: '724.5g',
          water: '507.2g',
          levain: '103.8g',
          salt: '14.5g',
          inoculation: '14%',
          rise: '25%');
    });

    testWidgets('should update values based on hydration level',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText ==
                  '${locale.inputPrefixHydration}:'),
          '85');
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.farenheit,
          temperature: '80',
          weight: '1350',
          hydration: '85',
          saltLevel: '2',
          flour: '670.5g',
          water: '570.0g',
          levain: '96.1g',
          salt: '13.4g',
          inoculation: '14%',
          rise: '25%');
    });

    testWidgets('should update values based on salt level', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText == '${locale.inputPrefixSalt}:'),
          '2.5');
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.farenheit,
          temperature: '80',
          weight: '1350',
          hydration: '85',
          saltLevel: '2.5',
          flour: '668.9g',
          water: '568.5g',
          levain: '95.9g',
          salt: '16.7g',
          inoculation: '14%',
          rise: '25%');
    });

    testWidgets('should convert degrees back to celsius', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.degreesCelsius));
      await tester.pumpAndSettle();

      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.celsius,
          temperature: '26.7',
          weight: '1350',
          hydration: '85',
          saltLevel: '2.5',
          flour: '668.9g',
          water: '568.5g',
          levain: '95.9g',
          salt: '16.7g',
          inoculation: '14%',
          rise: '25%');
    });

    testWidgets('should return the values to initial state', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();
      await _scrollUntilEnd(tester);

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.celsius,
          temperature: '26.7',
          weight: '1350',
          hydration: '85',
          saltLevel: '2.5',
          flour: '669.0g',
          water: '568.6g',
          levain: '95.7g',
          salt: '16.7g',
          inoculation: '14%',
          rise: '25%');

      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText ==
                  '${locale.inputPrefixTemperature}:'),
          '22');
      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText == '${locale.inputPrefixWeight}:'),
          '700');
      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText ==
                  '${locale.inputPrefixHydration}:'),
          '70');
      await tester.enterText(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText == '${locale.inputPrefixSalt}:'),
          '2');
      await tester.pumpAndSettle();

      _expectCalculatorValues(
          temperatureUnit: TemperatureUnit.celsius,
          temperature: '22',
          weight: '700',
          hydration: '70',
          saltLevel: '2',
          flour: '366.5g',
          water: '256.5g',
          levain: '69.6g',
          salt: '7.3g',
          inoculation: '19%',
          rise: '50%');
    });
  });
}
