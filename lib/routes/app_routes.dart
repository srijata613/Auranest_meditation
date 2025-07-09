import 'package:flutter/material.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/favorites_screen/favorites_screen.dart';
import '../presentation/meditation_detail_screen/meditation_detail_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String registrationScreen = '/registration-screen';
  static const String loginScreen = '/login-screen';
  static const String homeScreen = '/home-screen';
  static const String favoritesScreen = '/favorites-screen';
  static const String meditationDetailScreen = '/meditation-detail-screen';
  static const String settingsScreen = '/settings-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => HomeScreen(),
    registrationScreen: (context) => RegistrationScreen(),
    loginScreen: (context) => LoginScreen(),
    homeScreen: (context) => HomeScreen(),
    favoritesScreen: (context) => FavoritesScreen(),
    meditationDetailScreen: (context) => MeditationDetailScreen(),
    settingsScreen: (context) => SettingsScreen(),
    // TODO: Add your other routes here
  };
}
