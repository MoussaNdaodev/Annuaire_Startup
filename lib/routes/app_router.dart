import 'package:flutter/material.dart';
import '../models/startup.dart';
import '../screens/about_screen.dart';
import '../screens/startup_detail_screen.dart';
import '../screens/startup_form_screen.dart';
import '../screens/startup_list_screen.dart';

class AppRouter {
  AppRouter._();

  static const String list = '/';
  static const String detail = '/detail';
  static const String form = '/form';
  static const String about = '/about';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case list:
        return MaterialPageRoute(builder: (_) => const StartupListScreen());

      case detail:
        final startup = settings.arguments as Startup;
        return MaterialPageRoute(
          builder: (_) => StartupDetailScreen(startup: startup),
        );

      case form:
        final startup = settings.arguments as Startup?;
        return MaterialPageRoute(
          builder: (_) => StartupFormScreen(startupToEdit: startup),
        );

      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

      default:
        return MaterialPageRoute(builder: (_) => const StartupListScreen());
    }
  }
}
