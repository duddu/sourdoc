import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sourdoc/widgets/header.dart';

import 'helpers/get_widget_with_test_scaffold.dart';

void main() {
  group('Header', () {
    const String text = 'test header text';

    testWidgets('should have a text', (tester) async {
      await tester
          .pumpWidget(getWidgetWithTestScaffold(const Header(text: text)));

      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should have a semantics header', (tester) async {
      await tester
          .pumpWidget(getWidgetWithTestScaffold(const Header(text: text)));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics && widget.properties.header == true),
          findsOneWidget);
    });

    testWidgets('should apply a default padding', (tester) async {
      await tester
          .pumpWidget(getWidgetWithTestScaffold(const Header(text: text)));

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Padding &&
              widget.padding == const EdgeInsets.fromLTRB(0, 20, 0, 5)),
          findsOneWidget);
    });

    group('if paddingTop is provided', () {
      testWidgets('should apply a custom padding', (tester) async {
        const double paddingTop = 100;
        await tester.pumpWidget(getWidgetWithTestScaffold(
            const Header(text: text, paddingTop: paddingTop)));

        expect(
            find.byWidgetPredicate((Widget widget) =>
                widget is Padding &&
                widget.padding ==
                    const EdgeInsets.fromLTRB(0, paddingTop, 0, 5)),
            findsOneWidget);
      });
    });
  });
}
