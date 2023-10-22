import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/constants/style.dart' as style;
import 'package:sourdoc/widgets/glossary_page.dart';
import 'package:sourdoc/widgets/help_page.dart';
import 'package:sourdoc/widgets/home_page.dart';
import 'package:window_size/window_size.dart';

void _setupWindow() async {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    const double windowWidth = style.mobileMaxScreenWidth;
    const double windowHeight = 850;

    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));

    final screen = await getCurrentScreen();
    setWindowFrame(Rect.fromCenter(
      center: screen!.frame.center,
      width: windowWidth,
      height: windowHeight,
    ));
  }
}

void main() {
  _setupWindow();
  usePathUrlStrategy();
  runApp(const Sourdoc());
}

class Sourdoc extends StatelessWidget {
  const Sourdoc({super.key});

  ThemeData _getThemeData(BuildContext context) => ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, background: Colors.white),
      useMaterial3: true,
      fontFamily: 'Roboto, sans-serif, Arial',
      textTheme: TextTheme(
        bodySmall: const TextStyle(
            fontSize: 14.5,
            letterSpacing: kIsWeb ? 0.3 : 0.1,
            color: Colors.black87),
        bodyMedium: TextStyle(
            fontSize: style.isMobileScreenWidth(context) ? 14.5 : 16,
            letterSpacing: kIsWeb ? 0.3 : 0.1,
            color: Colors.black87),
        bodyLarge: const TextStyle(
            fontSize: 16,
            letterSpacing: kIsWeb ? 0.3 : 0.1,
            color: Colors.black87),
        headlineLarge: TextStyle(
            fontSize: 20,
            letterSpacing: kIsWeb ? 0.1 : 0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.primary),
      ));

  PageRouteBuilder _getPageRouteBuilder(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: locale.title,
        theme: _getThemeData(context),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case homePagePath:
              return _getPageRouteBuilder(settings, const HomePage());
            case helpPagePath:
              return _getPageRouteBuilder(settings, const HelpPage());
            case glossaryPagePath:
              return _getPageRouteBuilder(settings, const GlossaryPage());
            default:
              return MaterialPageRoute(builder: (context) => const HomePage());
          }
        });
  }
}
