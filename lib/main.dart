import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:sourdoc/constants/locale.dart' as locale;
import 'package:sourdoc/constants/routes.dart';
import 'package:sourdoc/widgets/glossary_page.dart';
import 'package:sourdoc/widgets/help_page.dart';
import 'package:sourdoc/widgets/home_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const Sourdoc());
}

class Sourdoc extends StatelessWidget {
  const Sourdoc({super.key});

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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
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
