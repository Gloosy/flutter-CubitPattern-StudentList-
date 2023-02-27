import 'package:flutter/material.dart';
import 'package:rive_animation/presentation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/presentation/screens/home/home_screen.dart';

class AppRouter {
  MaterialPageRoute? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Homepage());
      case "/navBar":
        return MaterialPageRoute(builder: (_) => EntryPoint());
      default:
        return null;
    }
  }
}
