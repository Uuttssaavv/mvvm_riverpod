import 'package:flutter/material.dart';
import 'package:flutter_project/features/authentication/authentication_view.dart';
import 'package:flutter_project/features/dashboard/dashboard_view.dart';
import 'package:flutter_project/screens/splash_screen.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AuthenticationView.routeName:
        return MaterialPageRoute(builder: (_) => const AuthenticationView());
      case DashboardView.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardView());
    }
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
