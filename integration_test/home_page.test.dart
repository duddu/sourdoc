import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sourdoc/widgets/home_page.dart';

import '../test/widgets/helpers/ignore_overflow_errors.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('HomePage', () {
    testWidgets('should load default form values', (tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is TextField &&
              widget.decoration!.prefixText == 'Salt level:' &&
              widget.controller!.text == '2'),
          findsOneWidget);
    });
  });
}
