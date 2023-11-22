import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tenniscourt/features/home/home_page.dart';

import 'extentions/routes_extentions.dart';
import 'style/themes.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tennis Court',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const HomePage(),
      routes: routesList(),
    );
  }
}


