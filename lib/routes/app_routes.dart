import 'package:flutter/material.dart';

import '../screens/auth/login_page.dart';
import '../screens/auth/register_page.dart';
import '../screens/reports/add_reports_page.dart';
import '../screens/home/home_page.dart';
import '../screens/landing/landing_page.dart';
import '../screens/profile/profile_page.dart';
import '../screens/reports/reports_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String reports = '/reports';
  static const String addReports = '/add-reports';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    home: (context) => const HomePage(),
    reports: (context) => const ReportsPage(),
    addReports: (context) => const AddReportsPage(),
    profile: (context) => const ProfilePage(),
  };
}
