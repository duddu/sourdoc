import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/main.dart';
import 'package:sourdoc/widgets/secondary_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation', () {
    testWidgets('should land on the home page', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHomeTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate to help page', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHelpTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate back from help to home via arrow button',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarHelpBackButtonTooltip));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHomeTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate back from help to home via back text button',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
          find.byType(BackToHomePageTextButton), 50);
      await tester.pumpAndSettle();
      await tester
          .tap(find.widgetWithIcon(TextButton, Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHomeTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate to glossary page', (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarHelpActionButtonTooltip));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarGlossaryTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate back from glossary to help via arrow button',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarHelpActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarGlossaryBackButtonTooltip));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHelpTitleLabel),
          findsOneWidget);
    });

    testWidgets('should navigate back from glossary to home via close button',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarHelpActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester
          .tap(find.byTooltip(locale.appBarGlossaryActionButtonTooltip));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHomeTitleLabel),
          findsOneWidget);
    });

    testWidgets(
        'should navigate back from glossary to home via back text button',
        (tester) async {
      await tester.pumpWidget(const Sourdoc());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip(locale.appBarHomeActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(locale.appBarHelpActionButtonTooltip));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
          find.byType(BackToHomePageTextButton), 50);
      await tester.pumpAndSettle();
      await tester
          .tap(find.widgetWithIcon(TextButton, Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(
          find.byWidgetPredicate((Widget widget) =>
              widget is Semantics &&
              widget.properties.label == locale.a11yAppBarHomeTitleLabel),
          findsOneWidget);
    });
  });
}
