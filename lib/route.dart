import 'package:flutter/material.dart';
import 'package:rive_animation/presentation/testscreens/homescreen_test.dart';
import 'package:rive_animation/presentation/testscreens/search_screen.dart';
import 'package:rive_animation/presentation/testscreens/update_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomepageTest.routeName :(context) => HomepageTest(),
  SearchScreen.routeName :(context) => SearchScreen(),
  UpdateScreen.routeName :(context) => UpdateScreen(),
};
